class ForbidenWord < ApplicationRecord

  scope :unvalid_after_quote_accepted, -> () {
    where.not(is_valid_after_quote_accepted: true)
  }
  scope :catched_words, -> () {
    where(is_catched_word: true)
  }
  scope :uncatched_words, -> () {
    where.not(is_catched_word: true)
  }
end
