class Worker < User
  has_one :company, dependent: :destroy
  before_create :build_company
  accepts_nested_attributes_for :company
  has_many :reviews, dependent: :destroy
  has_many :jobs
  belongs_to :profession, optional: true

  belongs_to :category, optional: true

  has_many :join_tag_workers
  has_many :tags, through: :join_tag_workers
  has_one_attached :banner

  def banner_url
    if banner.attached?
        ActiveStorage::Current.host = Rails.application.credentials.dig(Rails.env.to_sym, :host)
        banner.service_url
    else
      ActionController::Base.helpers.asset_path 'logo.png'
    end
  end

  def get_or_build_company
    company ||Company.new
  end
end
