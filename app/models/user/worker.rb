class Worker < User
  has_one :company
  has_many :reviews
  has_many :jobs
end
