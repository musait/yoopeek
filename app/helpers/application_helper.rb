module ApplicationHelper

  def number_to_currency(number, options = {})
    options[:locale] ||= I18n.locale
    super(number, options)
  end
  def have_one_room_with_user(user)
    authored_rooms.with_receiver(user).first ||received_rooms_with_author(user).first
  end
end
