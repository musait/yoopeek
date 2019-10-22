class Notification < ApplicationRecord
  belongs_to :quote, optional: true
  belongs_to :job, optional: true
  belongs_to :room_message, optional: true
  belongs_to :review, optional: true
  belongs_to :user, counter_cache: true
  include Rails.application.routes.url_helpers
  include ActionView::Helpers::UrlHelper

  scope :not_seen, -> () {
    where viewed_at: nil
  }

  def self.create_for user, object
    if object.class.superclass.to_s == "ApplicationRecord"
      class_to_s = object.class.to_s.underscore
    else
      class_to_s = object.class.superclass.to_s.underscore
    end

    create! user: user, class_to_s => object, message: "notifications.#{class_to_s}_created", created_for: class_to_s
  end

  def message_translate
    case created_for
    when "room_message"
      creator = room_message.author
    when "job"
      creator = job.customer
    when "quote"
      creator = quote.user
    when "review"
      creator = review.worker
    end
    I18n.t message, creator: creator.email
    # I18n.t message, creator: creator.email, href: link_to(I18n.t("notifications.#{created_for}_created_href"), url)
  end

  def url
    case created_for
    when "room_message"
      room_path(locale: I18n.locale, id: room_message.room_id)
    when "job"
      job_path(locale: I18n.locale, id: job.slug)
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
