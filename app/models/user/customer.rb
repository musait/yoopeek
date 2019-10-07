class Customer < User
  has_many :jobs, dependent: :destroy
  has_many :reviews
end
