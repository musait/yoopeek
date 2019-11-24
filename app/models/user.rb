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
  after_save :set_stripe_customer_id, if: Proc.new { stripe_customer_id.blank? }
  attr_accessor :account_token
  attr_accessor :person_token
  attr_accessor :bank_token
  has_one_attached :avatar
  phony_normalize :phone_number, default_country_code: 'FR'
  has_many :portfolios
  validates_presence_of :is_worker, message: :must_exist, if: Proc.new { |user| user.is_worker.nil? && !from_omniauth? }
  validates :firstname, presence: { message: :must_exist }
  validates :lastname, presence: { message: :must_exist }
  after_create :add_approval
  before_save :set_stripe_account
  after_create_commit :set_conv_with_yoopeek
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


    if bank_token.present?
      begin
        if account_id.present?
          bank_account = Stripe::Account.create_external_account(
            account_id,
            {
              external_account: bank_token,
            }
          )

          self.stripe_connect_bank_id = bank_account.id
        end
      rescue Stripe::InvalidRequestError => e
        p e
        account = nil
      end
    end
  end
  def avatar_url
    if avatar.attached?
      ActiveStorage::Current.host = Rails.application.credentials.dig(Rails.env.to_sym, :host)
      avatar.service_url
    else
      ActionController::Base.helpers.asset_path '/theme/user/hireo/images/user-avatar-placeholder.png'
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
  def add_approval
    self.approved = true
  end
  def self.types
    %w(Worker Customer)
  end

  def have_one_room_with_user(user)
    authored_rooms.with_receiver(user) || received_rooms.with_author(user)
  end

  def set_conv_with_yoopeek
    unless self.email == "yoopeek@yoopeek.com"
      @yoopeek_user = User.find_by(email:"yoopeek@yoopeek.com")
      @room = Room.create!(author: @yoopeek_user,receiver: self )
      if self.worker?
        RoomMessage.create(room: @room,author:@yoopeek_user,receiver:self, message:"Bienvenue sur Yoopeek. Chaque message vous coûtera 6 points. Si le client ne vous répond pas, vous serez remboursé intégralement.
        Si le client vous répond, mais qu'il n'y a pas de devis accepté, vous serez remboursé de 3 points")
      else
        RoomMessage.create(room: @room,author:@yoopeek_user,receiver:self, message:"Bienvenue sur Yoopeek.")
      end
    end
  end
  def send_admin_mail
    AdminMailer.new_user_waiting_for_approval(email).deliver if self.worker?
  end

  def set_stripe_customer_id
    StripeCustomer.create self if stripe_customer_id.blank?
  end

  def self.from_facebook(auth,params)
    @user = where(facebook_id: auth.uid).first_or_initialize do |user|
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
        # delete this line to approve user by admin
        user.approved = true
      else
        user.type = "Customer"
        user.is_worker = false
      end
      user.skip_confirmation!
    end
    @user.save!
    @user
  end

  def self.from_google(auth,params)
    @user = where(google_id: auth.uid).first_or_initialize do |user|
      user.email = auth.info.email
      user.firstname = auth.info.first_name
      user.lastname = auth.info.last_name
      user.password = Devise.friendly_token[0, 20]
      require 'open-uri'
      downloaded_image = open(auth.info.image)
      user.avatar.attach(io: downloaded_image, filename: 'avatar.jpg', content_type: downloaded_image.content_type)
      if params['isWorker'] == "1"
        user.type = "Worker"
        user.is_worker = true
        # delete this line to approve user by admin
        user.approved = true
      else
        user.type = "Customer"
        user.is_worker = false
      end
      user.skip_confirmation!
    end
    @user.save!
    @user
  end

  def full_name
    "#{self.firstname} #{self.lastname}"
  end

  def become_a_worker
    worker? ? becomes!(Worker) : becomes!(Customer)
  end

  def current_subscription
    subscriptions.current_actived_subscriptions.order(:plan_amount => :desc).first
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
    if current_credits >= credits
      remove_credits credits, create_for, element
      true
    else
      false
    end
  end

  def refund_credits credits
    update current_credits: (current_credits + credits)
  end

  def get_or_build_address
    address||Address.new
  end

  def from_omniauth?
    facebook_id || google_id
  end
end
