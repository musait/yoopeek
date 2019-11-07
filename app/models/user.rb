class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :validatable, :confirmable

  devise :omniauthable, omniauth_providers: [:facebook, :google_oauth2]

  self.inheritance_column = :type
  has_many :subscriptions
  has_many :authored_rooms, class_name: 'Room', foreign_key: 'author_id'
  has_many :received_rooms, class_name: 'Room', foreign_key: 'receiver_id'
  has_many :room_messages
  has_many :credits_payments
  has_many :notif_received, class_name: 'Notification', foreign_key: 'receiver_id'
  has_many :notif_send, class_name: 'Notification', foreign_key: 'sender_id'
  belongs_to :address, optional: true
  accepts_nested_attributes_for :address
  after_create :send_admin_mail
  after_save :set_stripe_customer_id, if: Proc.new { stripe_customer_id.blank? }
  attr_accessor :account_token
  attr_accessor :person_token
  acts_as_reader
  has_one_attached :avatar
  phony_normalize :phone_number, default_country_code: 'FR'
  has_many :portfolios

  before_save :set_stripe_account
  after_create :set_conv_with_yoopeek
  def set_stripe_account
    if account_token.present?
      begin
        if self.stripe_account_id.blank?
          account = Stripe::Account.create({
            country: "FR",
            type: "custom",
            account_token: account_token
          })
          self.stripe_account_id = account.id
        else
          account = Stripe::Account.update(
            self.stripe_account_id,
            account_token: account_token
          )
        end
      rescue Stripe::InvalidRequestError => e
        p e
        account = nil
      end
      account_id = account.try("id") ||stripe_account_id
      if (account_id.present?) &&person_token.present?
        begin
          if self.stripe_person_id.blank?
            person = Stripe::Account.create_person( account_id,
              {
                person_token: person_token
              }
            )
            self.stripe_person_id = person.id
          else
            person = Stripe::Account.update_person(
              account_id,
              self.stripe_person_id,
              {
                person_token: person_token
              }
            )
          end
        rescue Stripe::InvalidRequestError => e
          p e
          account = nil
        end
      end
    end
  end
  def avatar_url
    if avatar.attached?
      ActiveStorage::Current.host = Rails.application.credentials.dig(Rails.env.to_sym, :host)
      avatar.service_url
    else
      ActionController::Base.helpers.asset_path 'logo.png'
    end
  end
  def worker?
    is_a? Worker
  end
  def customer?
    is_a? Customer
  end
  def admin?
    is_a? Admin
  end
  def add_type
    self.type ="Customer"
  end
  def self.types
    %w(Worker Customer)
  end

  def have_one_room_with_user(user)
    authored_rooms.with_receiver(user) || received_rooms.with_author(user)
  end

  def set_conv_with_yoopeek
    unless self.email == "yoopeek@yoopeek.com"
      @room = Room.create(author_id: User.find_by(email:"yoopeek@yoopeek.com").id,receiver_id: self.id )

      RoomMessage.create(room: @room,author:User.find_by(email:"yoopeek@yoopeek.com"),receiver:self, message:"Bienvenue sur Yoopeek")
    end
  end
  def send_admin_mail
    AdminMailer.new_user_waiting_for_approval(email).deliver if self.is_worker?
  end

  def set_stripe_customer_id
    StripeCustomer.create self if stripe_customer_id.blank?
  end

  def self.from_facebook(auth,params)
    where(facebook_id: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.firstname = auth.info.name.partition(" ").first
      user.lastname = auth.info.name.partition(" ").last
      user.password = Devise.friendly_token[0, 20]
      # user.remote_avatar_url = auth.info.image
      require 'open-uri'
      downloaded_image = open(auth.info.image)
      user.avatar.attach(io: downloaded_image, filename: 'avatar.jpg', content_type: downloaded_image.content_type)
      if params['isWorker'] == "1"
        user.type = "Worker"
        user.is_worker = true
      else
        user.type = "Customer"
        user.is_worker = false
      end
      user.skip_confirmation!
    end
  end

  def self.from_google(auth,params)
    where(google_id: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.firstname = auth.info.first_name
      user.lastname = auth.info.last_name
      user.password = Devise.friendly_token[0, 20]
      require 'open-uri'
      downloaded_image = open(auth.info.image)
      user.avatar.attach(io: downloaded_image, filename: 'avatar.jpg', content_type: downloaded_image.content_type)
      if params['isWorker'] == "1"
        user.type = "Worker"
      else
        user.type = "Customer"
      end
      user.skip_confirmation!
    end
  end

  def full_name
    "#{self.firstname} #{self.lastname}"
  end

  def is_worker
    self.type == "Worker"
  end
  def is_customer
    self.type == "Customer"
  end
  def is_admin
    self.admin?
  end

  def current_subscription
    subscriptions.current_actived_subscriptions.first
  end

  def current_plan
    plan = current_subscription.try("plan_limitation")
    plan||PlanLimitation.free_limitation
  end

  def add_credits credits, create_for = nil, element = nil
    update total_credits: (total_credits + credits), current_credits: (current_credits + credits)
    if create_for.present? &&element.present?
      CreditChangement.create user: self, is_for_add: true, quantity: credits, create_for: create_for.to_sym, "#{create_for}_id" => element.id
    else
      CreditChangement.create user: self, is_for_add: true, quantity: credits, create_for: create_for.to_sym
    end
  end

  def remove_credits credits, create_for = nil, element = nil
    update current_credits: (current_credits - credits)
    if create_for.present? &&element.present?
      CreditChangement.create user: self, is_for_add: false, quantity: credits, create_for: create_for.to_sym, "#{create_for}_id" => element.id
    else
      CreditChangement.create user: self, is_for_add: false, quantity: credits, create_for: create_for.to_sym
    end
  end

  def pay_with_credits credits, create_for = nil, element = nil
    if current_credits > credits
      remove_credits credits, create_for, element
      true
    else
      false
    end
  end

  def refund_credits credits
    update current_credits: (current_credits + credits)
  end
end
