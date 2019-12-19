class PagesController < ApplicationController
  skip_before_action :authenticate_user!
  def show
    render template: "/pages/#{params[:page]}"
  end

  def send_mail_contact
    UserMailer.with(sender: params[:email], name: params[:name], subject: params[:subject], content: params[:content]).send_mail_contact.deliver_now
    redirect_to '/pages/contact', notice: t('.the_email_has_been_sent')
  end
end
