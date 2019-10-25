class ApplicationController < ActionController::Base
  protect_from_forgery prepend: true, with: :exception
  before_action :authenticate_user!
  before_action :set_locale
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :check_if_approved
  before_action :url_who_we_are_from
  before_action :count_notification


  def configure_permitted_parameters
    devise_parameter_sanitizer.permit:sign_up,keys: [:email, :password, :password_confirmation, :firstname, :lastname,:is_worker,:phone_number, :avatar, :address_attributes => [:id, :complete_address,:street, :city, :zip, :country],:company_attributes => [:id, :name, :iban, :subject_to_vat, :vat_number, :address_attributes =>[:id, :complete_address,:street, :city, :zip, :country]]]
    devise_parameter_sanitizer.permit:account_update,keys: [:email, :password, :password_confirmation, :firstname, :lastname,:is_worker,:phone_number, :avatar, :address_attributes => [:id, :complete_address,:street, :city, :zip, :country],:company_attributes => [:id, :name, :iban, :subject_to_vat, :vat_number, :address_attributes =>[:id, :complete_address,:street, :city, :zip, :country]]]
    devise_parameter_sanitizer.permit:sign_up,keys: [:email, :password, :password_confirmation, :firstname, :lastname,:is_worker,:profession_id,:phone_number,:address_attributes => [:id, :complete_address,:street, :city, :zip, :country],:company_attributes => [:id, :name, :iban, :website,:subject_to_vat, :vat_number, :address_attributes =>[:id, :complete_address,:street, :city, :zip, :country]]]
    devise_parameter_sanitizer.permit:account_update,keys: [:email, :password, :password_confirmation, :firstname, :lastname,:is_worker,:profession_id,:phone_number,:address_attributes => [:id, :complete_address,:street, :city, :zip, :country],:company_attributes => [:id, :name, :website,:iban, :subject_to_vat, :vat_number, :address_attributes =>[:id, :complete_address,:street, :city, :zip, :country]]]
  end

  def count_notification
    if current_user.present?
      @notifications_count = current_user.notifications.not_seen.size
      @notifications = current_user.notifications.not_seen.paginate(page: params[:notifications_page], per_page: params[:notifications_per_page])
    else
      @notifications_count = 0
      @notifications = []
    end
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


  def after_sign_in_path_for(resource_or_scope)
    if resource.is_admin
      admin_index_path
    else
      root_path
    end
  end

  def url_who_we_are_from
    begin
      url = Rails.application.routes.recognize_path(request.referrer)
      last_url = url[:controller] + "/" + url[:action]
    rescue
    end
  end

  def check_if_approved
    if current_user.present?
      if current_user.is_worker && !current_user.approved
        if url_who_we_are_from == "registrations/edit"
          if action_name ==  "destroy"
            sign_out current_user
          else
            sign_out current_user
            redirect_to new_user_session_path, notice: t('.your_information_are_saved')
          end
        else
          redirect_to edit_user_registration_path, notice: t('.fill_information')
        end
      end
    end
  end

end
