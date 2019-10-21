class RegistrationsController < Devise::RegistrationsController
  skip_before_action :check_if_approved, only: [:edit, :update]

  def create
    super
    if params[:user][:is_worker] == "1"
      @user.update(type: "Worker")
    else
      @user.update(type: "Customer")
    end
    if @user.persisted?
      sign_in_and_redirect @user, event: :authentification
    end
  end
  protected

  def update_resource(resource, params)
    resource.update_without_password(params)
  end
end
