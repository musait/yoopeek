class ApplicationController < ActionController::Base
  protect_from_forgery prepend: true, with: :exception
  before_action :authenticate_user!
  before_action :set_locale
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :check_if_approved
  before_action :count_notification


  def configure_permitted_parameters
    devise_parameter_sanitizer.permit:sign_up,keys: [:email, :password, :password_confirmation, :firstname, :lastname,:is_worker,:address_attributes => [:id, :complete_address,:street, :city, :zip, :country],:company_attributes => [:id, :name, :iban, :subject_to_vat, :vat_number, :address_attributes =>[:id, :complete_address,:street, :city, :zip, :country]]]
    devise_parameter_sanitizer.permit:account_update,keys: [:email, :password, :password_confirmation, :firstname, :lastname,:is_worker,:address_attributes => [:id, :complete_address,:street, :city, :zip, :country],:company_attributes => [:id, :name, :iban, :subject_to_vat, :vat_number, :address_attributes =>[:id, :complete_address,:street, :city, :zip, :country]]]
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

  def check_if_approved
    if current_user.present?
      if current_user.is_worker
        if !current_user.try(:approved?)
          sign_out current_user
          redirect_to new_user_session_path, alert: I18n.t('.devise.failure.not_approved')
        end
      end
    end
  end

end
