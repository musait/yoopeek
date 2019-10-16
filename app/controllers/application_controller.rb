class ApplicationController < ActionController::Base
  before_action :set_locale
  before_action :configure_permitted_parameters, if: :devise_controller?


  def configure_permitted_parameters
    devise_parameter_sanitizer.permit:sign_up,keys: [:email, :password, :password_confirmation, :firstname, :lastname,:address_attributes => [:id, :complete_address,:street, :city, :zip, :country],:company_attributes => [:id, :name, :iban, :subject_to_vat, :vat_number, :address_attributes =>[:id, :complete_address,:street, :city, :zip, :country]]]
    devise_parameter_sanitizer.permit:account_update,keys: [:email, :password, :password_confirmation, :firstname, :lastname,:address_attributes => [:id, :complete_address,:street, :city, :zip, :country],:company_attributes => [:id, :name, :iban, :subject_to_vat, :vat_number, :address_attributes =>[:id, :complete_address,:street, :city, :zip, :country]]]
  end


  private
  def set_locale
    I18n.locale = extract_locale || I18n.default_locale
  end
  def extract_locale
    parsed_locale = params[:locale]
    I18n.available_locales.map(&:to_s).include?(parsed_locale) ? parsed_locale : nil
  end
  def default_url_options
    { locale: I18n.locale }
  end
end
