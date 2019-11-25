class DeviseMailer < Devise::Mailer
  layout 'mailer'
  default from: "contact@yoopeek.com"
end
