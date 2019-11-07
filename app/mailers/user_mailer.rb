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

    def quote_paid
      @user = params[:user]
      @quote = params[:quote]
      mail(to: @user.email, subject: default_i18n_subject(user: @user.full_name))
    end

    def customer_declare_job_finished
      @user = params[:user]
      @job = params[:job]
      mail(to:@user.email,subject: default_i18n_subject(user: @user.full_name))
    end
    def worker_declare_job_finished
      @user = params[:user]
      @job = params[:job]
      mail(to:@user.email,subject: default_i18n_subject(user: @user.full_name))
    end
    def new_invoice
      mail(to:Worker.first,subject: default_i18n_subject(user: Worker.first.full_name))
    end

    def subscription_expiration
      mail(to:Worker.first, subject: default_i18n_subject(user: Worker.first.full_name))
    end
  end
