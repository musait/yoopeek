class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def facebook

      @user = User.from_facebook(request.env['omniauth.auth'],request.env['omniauth.params'])

    if @user.persisted?
      if @user.is_worker && !@user.approved?
        sign_in(@user)
        redirect_to edit_user_registration_path, notice: t('.fill_information')
      else
        sign_in_and_redirect @user, event: :authentification
      end
    else
      session['devise.facebook'] = request.env['omniauth.auth']
      redirect_to new_user_registration_url
    end
  end

  def google_oauth2
    @user = User.from_google(request.env['omniauth.auth'],request.env['omniauth.params'])

    if @user.persisted?
      if @user.is_worker && !@user.approved?
        sign_in(@user)
        redirect_to edit_user_registration_path, notice: t('.fill_information')
      else
        sign_in_and_redirect @user, event: :authentification
      end
    else
      session['devise.google_oauth2'] = request.env['omniauth.auth']
      redirect_to new_user_registration_url
    end
  end



end
