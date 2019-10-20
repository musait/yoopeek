class RegistrationsController < Devise::RegistrationsController
  skip_before_action :check_if_approved, only: [:edit, :update]

  def update
    super
  end
  protected

  def update_resource(resource, params)
    resource.update_without_password(params)
  end
end
