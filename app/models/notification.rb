class Notification < ApplicationRecord
  belongs_to :quote, optional: true
  belongs_to :job, optional: true
  belongs_to :room_message, optional: true
  belongs_to :review, optional: true
  belongs_to :sender, class_name: 'User', foreign_key: 'sender_id', counter_cache: true
  belongs_to :receiver, class_name: 'User', foreign_key: 'receiver_id', counter_cache: true
  include Rails.application.routes.url_helpers
  include ActionView::Helpers::UrlHelper
  include ActionView::Helpers::DateHelper
  paginates_per 3

  scope :not_seen, -> () {
    where viewed_at: nil
  }
  scope :seen, -> () {
    where viewed_at: "IS NOT NULL"
  }
  after_create do
    UserChannel.broadcast_to self.receiver.id, self.attributes.merge!(url: self.url, raw_message: message.to_s.html_safe, author_avatar: sender.avatar_url, author_full_name: sender.full_name, time_ago_in_words: time_ago_in_words(self.created_at))
  end
  def self.create_for sender,receiver, object, message_action = "created"
    if object.class.superclass.to_s == "ApplicationRecord"
      class_to_s = object.class.to_s.underscore
    else
      class_to_s = object.class.superclass.to_s.underscore
    end

    create! sender: sender, receiver: receiver, class_to_s => object, message: "notifications.#{class_to_s}_#{message_action}", created_for: class_to_s
  end

  # def message_translate
  #   case created_for
  #   when "room_message"
  #     creator = room_message.author
  #   when "job"
  #     creator = job.customer
  #   when "quote"
  #     if quote.nil?
  #       creator = self.sender
  #     else
  #       creator = quote.sender
  #     end
  #     job = quote.job.name
  #   when "review"
  #     creator = review.worker
  #   end
  #   I18n.t message, creator: creator.full_name, job: job
  #   # I18n.t message, creator: creator.email, href: link_to(I18n.t("notifications.#{created_for}_created_href"), url)
  # end

  def url
    case created_for
    when "room_message"
      room_path(locale: I18n.locale, id: room_message.room_id)
    when "job"
      job_path(locale: I18n.locale, slug: job.slug)
    when "quote"
      quote_path(locale: I18n.locale, id: quote.id)
    when "review"
      review_path(locale: I18n.locale, id: review.id)
    end
  end

  def self.set_seen notifications, set_by, ids
    if notifications.present? &&ids.present?
      seen_notifications = notifications.not_seen.where "#{set_by}_id" => ids
      seen_notifications.each do |seen_notification|
        seen_notification.update viewed_at: Time.current
      end
    end
  end
end
