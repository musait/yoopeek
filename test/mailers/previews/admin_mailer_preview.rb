# located in test/mailers/previews/notifier_mailer_preview.rb

class AdminMailerPreview < ActionMailer::Preview
  # Accessible from http://localhost:3000/rails/mailers/notifier/welcome
  def new_user_waiting_for_approval
    AdminMailer.new_user_waiting_for_approval(User.first)
  end
end
