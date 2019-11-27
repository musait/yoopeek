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

  def edit
    @professions = Profession.all
    @profession= Profession.find_by(id: current_user.profession_id) || @professions.first
    @subcategories = @profession.subcategories || Subcategory.all
    super
  end

  def update
    @professions = Profession.all
    @subcategories = Subcategory.all

    super
  end

  protected

  def after_update_path_for(resource)
    if resource.worker?
      user_path(resource)
    else
      root_path
    end
  end

  def update_resource(resource, params)
    if !params[:password].empty?
      resource.password = params[:password]
      resource.password_confirmation = params[:password_confirmation]
    end

    resource.update_without_password(params)
  end
end
