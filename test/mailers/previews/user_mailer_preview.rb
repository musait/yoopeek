# located in test/mailers/previews/notifier_mailer_preview.rb

class UserMailerPreview < ActionMailer::Preview
  # Accessible from http://localhost:3000/rails/mailers/notifier/welcome
  def confirmation_instructions
    UserMailer.confirmation_instructions(User.first,@token)
  end

  def reset_password_instructions
    UserMailer.reset_password_instructions(User.first,@token)
  end

  def new_quote
    UserMailer.with(user: User.first, quote: Quote.first).new_quote

  end

  def quote_paid
    UserMailer.with(user: User.first, quote: Quote.first).quote_paid
  end

  def quote_declined
    UserMailer.with(user: User.first, quote: Quote.first).quote_declined
  end

  def new_invoice
    UserMailer.with(user: Worker.first).new_invoice
  end

  def subscription_expiration
    UserMailer.with(user:Worker.first).subscription_expiration
  end
end
