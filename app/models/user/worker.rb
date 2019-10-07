class Worker < User
  has_one :company, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :jobs
end
