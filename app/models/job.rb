class Job < ApplicationRecord
  belongs_to :category
  belongs_to :subcategory
  belongs_to :worker, optional: true
  belongs_to :customer
  belongs_to :format_delivery, optional: true
  has_many :rooms, dependent: :destroy
  has_many :quotes, dependent: :destroy
  has_one :invoice, dependent: :destroy
  has_one :notification, dependent: :destroy
  paginates_per 3
  validates_numericality_of :max_price, presence: true, :message => :is_not_a_number
  validates_numericality_of :max_price, :greater_than => 0.0, :message => :has_to_be_greather_than_zero


  validates_numericality_of :min_price, presence: true, :message => :is_not_a_number
  validates_numericality_of :min_price, :greater_than => 0.0, :message => :has_to_be_greather_than_zero

  validates_numericality_of :max_price, :greater_than => :min_price , :message => :has_to_be_greather
  validates_numericality_of :min_time, presence: true, :message => :is_not_a_number
  validates_numericality_of :min_time, :greater_than => 0.0, :message => :has_to_be_greather_than_zero


  validates_numericality_of :max_time, presence: true, :message => :is_not_a_number
  validates_numericality_of :max_time, :greater_than => 0.0, :message => :has_to_be_greather_than_zero


  validates_numericality_of :max_time, :greater_than => :min_time, :message => :has_to_be_greather
  validates :date_delivery, inclusion: { in: (Date.yesterday..Date.today+5.years) },:allow_blank => false, :if => :date_delivery_changed?

  after_validation :set_slug, only: [:create, :update]
  enum status: [:created, :in_progress, :cancelled, :completed_by_worker, :completed_by_customer]
  after_save :send_notification_and_email, if :status_changed?


  def send_notification_and_email
    case self.status
      when "completed_by_worker"
        Notification.create!(message: I18n.t('.jobs.finished.worker_declare_job_finished',pro: self.worker.full_name, job_name: self.name), job: self,created_for: self.class.to_s.underscore, sender: self.worker, receiver: self.customer)
        UserMailer.with(user: self.customer, job: self).worker_declare_job_finished.deliver_now
      when "completed_by_customer"
        Notification.create!(message: I18n.t('.jobs.finished.customer_declare_job_finished',customer: self.customer.full_name,job_name: self.name), job: self, created_for: self.class.to_s.underscore, sender: self.customer, receiver: self.worker)
        UserMailer.with(user: self.worker, job: self).customer_declare_job_finished.deliver_now
      end
    end
  end

  def current_quote
    quotes.order(:created_at).last
  end

  def price_range
    "#{self.min_price} - #{self.max_price}"
  end
  def time_range
    "#{self.min_time} - #{self.max_time}"
  end
  def set_slug
    self.slug = name.to_s.parameterize
  end
  def to_param
    "#{slug}"
  end
end
