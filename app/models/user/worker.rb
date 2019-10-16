class Worker < User
  has_one :company, dependent: :destroy
  accepts_nested_attributes_for :company
  has_many :reviews, dependent: :destroy
  has_many :jobs
  belongs_to :profession
end
