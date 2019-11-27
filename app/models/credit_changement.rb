class CreditChangement < ApplicationRecord
  belongs_to :user
  belongs_to :CreditsPayment, optional: true
  belongs_to :Subscription, optional: true
  belongs_to :room, optional: true

  enum create_for: [:credits_payment, :subscription, :room]
end
