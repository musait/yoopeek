class Worker < User
  has_one :company, :class_name => 'Company', :foreign_key => 'user_id'
  has_many :reviews
end
