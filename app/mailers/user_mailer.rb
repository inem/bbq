class UserMailer < ApplicationMailer
  def registration(registration)
    @email = registration.email
    mail to: @email, subject: I18n.t('user_mailer.new_registration.subject')
  end
end
