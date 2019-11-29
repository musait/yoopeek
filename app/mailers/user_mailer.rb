class UserMailer < Devise::Mailer
    layout "mailer"
    default from: 'contact@yoopeek.com'
    default "Message-ID"=>"#{Digest::SHA2.hexdigest(Time.now.to_i.to_s)}@yoopeek.com"

    def send_mail_contact
      @sender_email = params[:sender]
      @sender_name = params[:name]
      @subject = params[:subject]
      @content = params[:content]
      mail(
        from: @sender_email,
        to: 'yoopeekonline@gmail.com',
        subject: @subject
      )
    end

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

    def new_worker_invoice
      @user = params[:user]
      @invoice = params[:invoice]
      mail(to:@user,subject: default_i18n_subject(user: @user.full_name))
    end
    
    def new_customer_invoice
      @user = params[:user]
      @invoice = params[:invoice]
      mail(to:@user,subject: default_i18n_subject(user: @user.full_name))
    end

    def subscription_expiration
      mail(to:Worker.first, subject: default_i18n_subject(user: Worker.first.full_name))
    end
  end
