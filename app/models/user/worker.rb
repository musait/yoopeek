class Worker < User
  has_one :company, dependent: :destroy
  before_create :build_company
  accepts_nested_attributes_for :company
  has_many :reviews, dependent: :destroy
  has_many :jobs
  belongs_to :profession, optional: true
end
