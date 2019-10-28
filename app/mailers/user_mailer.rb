class UserMailer < Devise::Mailer
    default from: 'notifications@yoopeek.com'


    def new_quote
      @user = params[:user]
      @quote = params[:quote]
      mail(to: @user.email, subject: 'You have a new quote')
    end

    def quote_declined
      @user = params[:user]
      @quote = params[:quote]
      mail(to: @user.email, subject: 'You have a new quote')
    end
  end
