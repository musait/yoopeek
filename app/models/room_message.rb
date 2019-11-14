class RoomMessage < ApplicationRecord
  belongs_to :room
  belongs_to :author, class_name: 'User', foreign_key: 'author_id'
  belongs_to :receiver, class_name: 'User', foreign_key: 'receiver_id'
  acts_as_readable on: :created_at
  has_one :notification, dependent: :destroy
  scope :valid_messages, -> () {
    where(is_valid: true)
  }
  scope :unvalid_messages, -> () {
    where.not(is_valid: true)
  }
  scope :catched_messages, -> () {
    valid_messages.where(is_catched: true)
  }
  validate :check_author_credits,unless: -> {User.unscoped.find(self.author_id).email == "yoopeek@yoopeek.com"}
  before_validation :content_valid?
  FILTERS = ["valid_message", "unvalid_message", "catched_message"]
  REGEX_EMAIL = /[\w+\-.]+@[a-z\d\-.]+\.[a-z]+/
  REGEX_URL = /(http|https):\/\/|[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,6}(:[0-9]{1,5})?(\/.*)?/
  REGEX_PHONE = /(?:(?:\+|00)33[\s.-]{0,3}(?:\(0\)[\s.-]{0,3})?|0)[1-9](?:(?:[\s.-]?\d{2}){4}|\d{2}(?:[\s.-]?\d{3}){2})/
  def check_author_credits
    worker = author.worker? ? author : receiver
    errors.add "credits", I18n.t("not_enougth_credits") if room.room_messages.where(author_id: worker.id).count == 0 &&!CreditChangement.exists?(room_id: room_id, user_id: worker.id)&&author.worker?
  end

  def content_valid?
    quote = room.try("job").try("current_quote")
    if quote.blank? ||(quote.present? &&quote.created?)
      forbiden_words_used = (ForbidenWord.uncatched_words.pluck(:word) & message.split)
      catched_words_used = (ForbidenWord.catched_words.pluck(:word) & message.split)
      set_unvalid message.scan( REGEX_EMAIL).flatten.compact.join("; ") if message.scan(REGEX_EMAIL).flatten.compact.present?
      set_unvalid message.scan( REGEX_URL).flatten.compact.join("; ") if message.scan(REGEX_URL).flatten.compact.present?
      set_unvalid message.scan( REGEX_PHONE).flatten.compact.join("; ") if message.scan(REGEX_PHONE).flatten.compact.present?
      set_unvalid forbiden_words_used.join("; ") if forbiden_words_used.present?
      set_unvalid(catched_words_used.join("; "), true) if catched_words_used.present?
    else
      forbiden_words_used = (ForbidenWord.uncatched_words.unvalid_after_quote_accepted.pluck(:word) & message.split)
      catched_words_used = (ForbidenWord.catched_words.unvalid_after_quote_accepted.pluck(:word) & message.split)
      set_unvalid forbiden_words_used.join("; ") if forbiden_words_used.present?
      set_unvalid(catched_words_used.join("; "), true) if catched_words_used.present?
    end

  end

  def set_unvalid unvalid_reason = nil, is_catched = false
    if is_catched
      self.is_catched = true
      self.catched_reason = self.catched_reason.blank? ? unvalid_reason : "; #{unvalid_reason}"
    else
      self.is_valid = false
      self.unvalid_reason = self.unvalid_reason.blank? ? unvalid_reason : "; #{unvalid_reason}"
    end

  end
end
