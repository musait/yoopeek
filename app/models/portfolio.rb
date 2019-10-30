class Portfolio < ApplicationRecord
  belongs_to :user
  belongs_to :job
  has_many_attached :picture

  def picture_url
    if picture.attached?
      ActiveStorage::Current.set(host: Rails.application.credentials.dig(Rails.env.to_sym, :host)) do
        picture[0].service_url
      end
    else
      ActionController::Base.helpers.asset_path 'logo.png'
    end
  end
end
