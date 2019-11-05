class CreditsPayment < ApplicationRecord
  belongs_to :user

  after_create do
    user.add_credits credits_add, "credits_payment", self
  end
end
