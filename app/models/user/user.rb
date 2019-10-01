class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :validatable, :confirmable

  devise :omniauthable, omniauth_providers: [:facebook, :google_oauth2]
  has_many :jobs

  self.inheritance_column = :type

  # We will need a way to know which animals
  # will subclass the Animal model
  def self.types
    %w(Worker User)
  end

  def self.from_facebook(auth)
    where(facebook_id: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.firstname = auth.info.name.partition(" ").first
      user.lastname = auth.info.name.partition(" ").last
      user.password = Devise.friendly_token[0, 20]
      user.skip_confirmation!
    end
  end

  def self.from_google(auth)
    where(google_id: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.firstname = auth.info.first_name
      user.lastname = auth.info.last_name
      user.password = Devise.friendly_token[0, 20]
      user.skip_confirmation!
    end
  end

  def full_name
    "#{self.firstname} #{self.lastname}"
  end

  def is_worker
    self.type == "Worker"
  end
end
