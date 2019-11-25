class Worker < User
  has_one :company, dependent: :destroy
  accepts_nested_attributes_for :company
  has_many :reviews, dependent: :destroy
  has_many :jobs
  belongs_to :profession, optional: true
  after_create :get_or_build_company
  belongs_to :category, optional: true

  has_many :join_tag_workers
  has_many :tags, through: :join_tag_workers


  

  def get_or_build_company
    company ||Company.new
  end
end
