class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def facebook
    if request.env['omniauth.params']
      @user = Worker.from_facebook(request.env['omniauth.auth'],request.env['omniauth.params'])
    else
      @user = Customer.from_facebook(request.env['omniauth.auth'],request.env['omniauth.params'])
    end
    if @user.persisted?
      if @user.is_worker && !@user.approved?
        sign_in(@user)
        redirect_to edit_user_registration_path, notice: 'Veuillez remplir les champs conçernant votre profil et celui de votre entreprise afin que votre inscription en tant que professionel soit pris en compte'
      else
        sign_in_and_redirect @user, event: :authentification
      end
    else
      session['devise.facebook'] = request.env['omniauth.auth']
      redirect_to new_user_registration_url
    end
  end

  def google_oauth2
    if request.env['omniauth.params']
      @user = Worker.from_facebook(request.env['omniauth.auth'],request.env['omniauth.params'])
    else
      @user = Customer.from_facebook(request.env['omniauth.auth'],request.env['omniauth.params'])
    end
    if @user.persisted?
      if @user.is_worker && !@user.approved?
        sign_in(@user)
        redirect_to edit_user_registration_path, notice: 'Veuillez remplir les champs conçernant votre profil et celui de votre entreprise afin que votre inscription en tant que professionel soit pris en compte'
      else
        sign_in_and_redirect @user, event: :authentification
      end
    else
      session['devise.google_oauth2'] = request.env['omniauth.auth']
      redirect_to new_user_registration_url
    end
  end



end
