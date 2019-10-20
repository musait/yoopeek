class AdminController < ApplicationController
  layout'admin'
  before_action :set_database
  before_action :is_admin?

  def index

  end

  def set_database
    @jobs = Job.all
    @categories = Category.all
    @users = User.all
  end

  def is_admin?
    if current_user.present?
      if current_user.is_admin
      else
        redirect_to root_path, alert: "Vous devez être administrateur pour vous rendre sur cette page"
      end
    else
      redirect_to new_user_session_path, alert: "Vous devez être connecté et être administrateur pour vous rendre sur cette page"
    end
  end

end
