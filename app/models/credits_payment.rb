class CreditsPayment < ApplicationRecord
  belongs_to :user

  after_create do
    user.add_credits credits_add
  end
end
