class Admin::UsersController <  AdminController

  def index
    if params[:filter].present?
      if params[:filter] == "approved"
        @users = User.where(approved: true).where("id != ?", current_user.id)
      elsif params[:filter] == "unapproved"
        @users = User.where(approved: false).where("id != ?", current_user.id)
      elsif params[:filter] == "pro"
        binding.pry
        @users = User.where(is_worker: true).where("id != ?", current_user.id)
      elsif params[:filter] == "cus"
        @users = User.where(is_worker: false).where("id != ?", current_user.id)
      end
    else
      @users = User.all.where("id != ?", current_user.id)
    end
    respond_to do |format|
      format.html
      format.js
    end
  end

  def show
    @user = User.find(params[:id])
    respond_to do |format|
      format.html
      format.js
    end
  end

  def update
    @user = User.find(params[:id])
    if params[:approved] == "false"
      @user.update(approved:false)
    elsif params[:approved] == "true"
      @user.update(approved:true)
    end
    @user.save
  end






  private

  def user_params
    params.permit(:id, :approved)
  end
end
