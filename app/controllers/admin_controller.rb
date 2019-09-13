class AdminController < ApplicationController
  layout'admin'
  # before_action :require_admin

  def index

  end
  # Methods omitted

  # def require_admin
  #   unless current_user.admin?
  #     redirect_to root_path
  #   end
  # end
end
