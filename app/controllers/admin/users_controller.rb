class Admin::UsersController <  AdminController
  before_action :set_user, only: [:edit, :update, :destroy, :show]
  def index
    if params[:filter].present?
      if params[:filter] == "approved"
        @users = User.where(approved: true).where(is_worker: true)
      elsif params[:filter] == "unapproved"
        @users = User.where(approved: false)
      elsif params[:filter] == "pro"
        @users = User.where(is_worker: true)
      elsif params[:filter] == "cus"
        @users = User.where(is_worker: false)
      end
    else
      @users = User.all
    end
    respond_to do |format|
      format.html
      format.js
    end
  end

  def show
    respond_to do |format|
      format.html
      format.js
    end
  end
  def edit
    set_edit_show
  end
  def update
    if params[:approved] == "false"
      @user.update(approved:false)
    elsif params[:approved] == "true"
      @user.update(approved:true)
    else
      if params[:user][:password].present?
        @user.attributes = user_params.merge!(password: params[:user][:password], password_confirmation: params[:user][:password_confirmation])
      else
        @user.attributes = user_params
      end
    end

    respond_to do |format|
      format.html {
        if @user.save
          redirect_to admin_users_path, notice: "L'utilisateur a été mis à jour avec succès"
        else
          set_edit_show
          render :edit
        end
      }
      if @user.save
        format.js { flash.now[:notice] = "L'utilisateur a été mis à jour avec succès" }
      end
    end
  end
  def destroy
    if @user.id != current_user.id
      @user.soft_delete!
    end
    redirect_to admin_users_path
  end

  private
  def set_user
    @user = User.find(params[:id])
  end
  def set_edit_show
    if @user.worker?
      @professions = Profession.all
      @profession= Profession.find_by(id: @user.profession_id) || @professions.first
      @subcategories = @profession.subcategories || Subcategory.all
    end
  end
  def user_params
    params.require(:user).permit(:bank_token, :birthdate, :account_token, :person_token, :email, :firstname, :lastname,:is_worker,:description,:profession_id,:phone_number,:price_rate,:banner,:avatar,:facebook_profile,:instagram_profile,:pinterest_profile,:twitter_profile,:category_id,:skills => [],:address_attributes => [:id, :complete_address,:street, :city, :zip, :country],:tag_ids => [],:subcategory_ids => [], :company_attributes => [:id, :website,:name, :iban, :subject_to_vat, :vat_number,:vat_rate,:currency, :address_attributes =>[:id, :complete_address,:street, :city, :zip, :country]])
  end
end
