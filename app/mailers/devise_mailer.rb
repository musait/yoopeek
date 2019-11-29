class DeviseMailer < Devise::Mailer
  layout 'mailer'
  default from: "contact@yoopeek.com"
  default "Message-ID"=>"#{Digest::SHA2.hexdigest(Time.now.to_i.to_s)}@yoopeek.com"
end
