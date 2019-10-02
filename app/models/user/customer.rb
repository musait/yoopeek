class Customer < User
  has_many :jobs
  has_many :reviews
end
