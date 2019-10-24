class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :validatable, :confirmable

  devise :omniauthable, omniauth_providers: [:facebook, :google_oauth2]

  self.inheritance_column = :type
  has_many :authored_rooms, class_name: 'Room', foreign_key: 'author_id'
  has_many :received_rooms, class_name: 'Room', foreign_key: 'receiver_id'
  has_many :room_messages
  has_many :notifications
  belongs_to :address, optional: true
  accepts_nested_attributes_for :address
  after_create :send_admin_mail
  after_save :set_stripe_customer_id, if: Proc.new { stripe_customer_id.blank? }
  attr_accessor :account_token
  attr_accessor :person_token
  acts_as_reader
  has_one_attached :avatar
  phony_normalize :phone_number, default_country_code: 'FR'

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

  def send_admin_mail
    AdminMailer.new_user_waiting_for_approval(email).deliver
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

end
