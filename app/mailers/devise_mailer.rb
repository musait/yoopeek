class DeviseMailer < Devise::Mailer
  layout 'mailer'
  default from: "notifications@yoopeek.com"
end
