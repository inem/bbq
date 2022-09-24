class RegistrationsController < Devise::RegistrationsController
  def create
    super
    MailSenderJob.perform_registration_mail(@user) if @user.persisted?
  end
end
