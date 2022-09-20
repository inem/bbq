class ApplicationMailer < ActionMailer::Base
  default from: Rails.application.credentials.dig(:sender_mail)
  layout "mailer"
end
