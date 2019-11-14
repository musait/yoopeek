class PagesController < ApplicationController
  skip_before_action :authenticate_user!
  def show
    render template: "pages/#{params[:page]}"
  end

  def send_mail_contact
    binding.pry
    UserMailer.with(sender: params[:email], name: params[:name], subject: params[:subject], content: params[:content]).send_mail_contact.deliver_now
    redirect_to '/pages/contact'
  end
end
