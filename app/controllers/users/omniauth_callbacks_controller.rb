class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def facebook
    @user = User.from_facebook(request.env['omniauth.auth'])
    if @user.persisted?
      sign_in_and_redirect @user, event: :authentification
    else
      session['devise.facebook'] = request.env['omniauth.auth']
      redirect_to new_user_registration_url
    end
  end

  def google_oauth2
    # auth = request.env["omniauth.auth"]
    # user = User.where(provider: auth["provider"], uid: auth["uid"]).first_or_initialize(email: auth["info"]["email"])
    # user.name ||= auth["info"]["name"]
    # user.save!
    #
    # user.remember_me = true
    # sign_in(:user, user)
    #
    # redirect_to after_sign_in_path_for(user)
    @user = User.from_google(request.env['omniauth.auth'])
    if @user.persisted?
      sign_in_and_redirect @user, event: :authentification
    else
      session['devise.google_oauth2'] = request.env['omniauth.auth']
      redirect_to new_user_registration_url
    end
  end

end
