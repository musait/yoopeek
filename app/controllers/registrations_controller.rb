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
      if @user.is_worker && !@user.approved?
        sign_in(@user)
        redirect_to edit_user_registration_path, notice: 'Veuillez remplir les champs conçernant votre profil et celui de votre entreprise afin que votre inscription en tant que professionel soit pris en compte'
      else
        sign_in_and_redirect @user, event: :authentification
      end
    end
  end
  protected

  def update_resource(resource, params)
    resource.update_without_password(params)
  end
end
