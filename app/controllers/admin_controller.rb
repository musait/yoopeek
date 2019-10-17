class AdminController < ApplicationController
  layout'admin'
  before_action :set_database
  before_action :require_admin

  def index

  end
  # Methods omitted

  # def require_admin
  #   unless current_user.admin?
  #     redirect_to root_path
  #   end
  # end
  def set_database
    @jobs = Job.all
    @categories = Category.all
    @users = User.all
  end
  def require_admin
    if current_user
      redirect_to root_path, alert: "Vous devez être administrateur pour vous rendre sur cette page" unless current_user.admin?
    else
      redirect_to new_user_session_path, alert: "Vous devez être connecté et être administrateur pour vous rendre sur cette page"

    end
  end
end
