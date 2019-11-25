class UserMailer < Devise::Mailer
    layout "mailer"
    default from: 'contact@yoopeek.com'

    def send_mail_contact
      attachments.inline['image.png'] = File.read('public/theme/user/hireo/images/logo.png')
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
      attachments.inline['image.png'] = File.read('public/theme/user/hireo/images/logo.png')
      @user = params[:user]
      @quote = params[:quote]
      mail(to: @user.email, subject: default_i18n_subject(user: @user.full_name))
    end

    def quote_declined
      attachments.inline['image.png'] = File.read('public/theme/user/hireo/images/logo.png')
      @user = params[:user]
      @quote = params[:quote]
      mail(to: @user.email, subject: default_i18n_subject(user: @user.full_name))
    end

    def quote_paid
      attachments.inline['image.png'] = File.read('public/theme/user/hireo/images/logo.png')
      @user = params[:user]
      @quote = params[:quote]
      mail(to: @user.email, subject: default_i18n_subject(user: @user.full_name))
    end

    def customer_declare_job_finished
      attachments.inline['image.png'] = File.read('public/theme/user/hireo/images/logo.png')
      @user = params[:user]
      @job = params[:job]
      mail(to:@user.email,subject: default_i18n_subject(user: @user.full_name))
    end
    def worker_declare_job_finished
      attachments.inline['image.png'] = File.read('public/theme/user/hireo/images/logo.png')
      @user = params[:user]
      @job = params[:job]
      mail(to:@user.email,subject: default_i18n_subject(user: @user.full_name))
    end
    def new_invoice
      @user = params[:user]
      @invoice = params[:invoice]
      attachments.inline['image.png'] = File.read('public/theme/user/hireo/images/logo.png')
      mail(to:@user,subject: default_i18n_subject(user: @user.full_name))
    end

    def subscription_expiration
      attachments.inline['image.png'] = File.read('public/theme/user/hireo/images/logo.png')
      mail(to:Worker.first, subject: default_i18n_subject(user: Worker.first.full_name))
    end
  end
