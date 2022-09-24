class RegistrationsController < Devise::RegistrationsController
  def create
    super
    RegistrationMailSenderJob.perform_later(@user) if @user.persisted?
  end
end
