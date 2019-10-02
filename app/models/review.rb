class Review < ApplicationRecord
  belongs_to :customer, :class_name => "Customer", :foreign_key => "customer_id"
  belongs_to :worker, :class_name => "Worker", :foreign_key => "worker_id"
  belongs_to :job
end
