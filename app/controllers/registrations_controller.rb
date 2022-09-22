class RegistrationsController < Devise::RegistrationsController
  def create
    super
    UserMailer.registration(@user).deliver_later if @user.persisted?
  end
end
