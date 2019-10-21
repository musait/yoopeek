class Review < ApplicationRecord
  belongs_to :customer, :class_name => "Customer", :foreign_key => "customer_id"
  belongs_to :worker, :class_name => "Worker", :foreign_key => "worker_id"
  belongs_to :job
  has_one :notification

  after_create :create_notification

  def create_notification
    Notification.create_for customer, self
  end
end
