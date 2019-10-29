module ApplicationHelper

  # def number_to_currency(number, options = {})
  #   options[:locale] ||= I18n.locale
  #   super(number, options)
  # end
  def currency_formated number, free_string = false
    if free_string &&number == 0
      "Gratuit"
    else
      number_to_currency number, strip_insignificant_zeros: true
    end
  end
  def have_one_room_with_user(user)
    authored_rooms.with_receiver(user).first ||received_rooms_with_author(user).first
  end
end
