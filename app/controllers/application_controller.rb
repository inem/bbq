class ApplicationController < ActionController::Base
  include Pundit::Authorization
  
  before_action :configure_permitted_parameters, if: :devise_controller?
  helper_method :current_user_can_edit?
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:account_update, keys: [:password, :password_confirmation, :current_password])
  end

  def current_user_can_edit?(model)
    user_signed_in? && (model.user == current_user || (model.try(:event).present? && model.event.user == current_user))
  end

  def pundit_user
    if params[:pincode].present? && @event.pincode_valid?(params[:pincode])
      @user.cookies.permanent["events_#{@event.id}_pincode"] = params[:pincode]
    end

    UserContext.new(current_user, cookies.permanent["events_#{@event.id}_pincode"])
  end

  private

  def user_not_authorized
    flash[:alert] = t('pundit.not_authorized')
    redirect_to(request.referrer || root_path)
  end
end

class UserContext
  attr_reader :user, :pincode
  delegate :user, to: :@user, allow_nil: true, prefix: "name"

  def initialize(user, event_pincode)
    @user = user
    @event_pincode = event_pincode
  end
end
