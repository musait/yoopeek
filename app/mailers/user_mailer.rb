class UserMailer < Devise::Mailer
    default from: 'notifications@yoopeek.com'


    def new_quote
      @user = params[:user]
      @quote = params[:quote]
      mail(to: @user.email, subject: default_i18n_subject(user: @user.full_name))
    end

    def quote_declined
      @user = params[:user]
      @quote = params[:quote]
      mail(to: @user.email, subject: default_i18n_subject(user: @user.full_name))
    end
  end
