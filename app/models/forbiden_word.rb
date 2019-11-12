class ForbidenWord < ApplicationRecord

  scope :unvalid_after_quote_accepted, -> () {
    where.not(is_valid_after_quote_accepted: true)
  }
end
