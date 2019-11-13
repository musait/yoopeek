class StripePayout < ApplicationRecord
  belongs_to :user
  after_create do
    user.update available_payout_amount: 0
  end
end
