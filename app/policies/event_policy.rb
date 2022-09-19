class EventPolicy < ApplicationPolicy
  def create?
    user.present?
  end

  def edit?
    @record.user == @user
  end

  def destroy?
    edit?
  end
  
  def show?
    password_guard!
  end
  
  def update?
    edit?
  end

  private

  def password_guard!
    return true if @record.pincode.blank? || edit?
  
    if params[:pincode].present? && @record.pincode_valid?(params[:pincode])
      @user.cookies.permanent["events_#{@record.id}_pincode"] = params[:pincode]
    end
  
    true if @record.pincode_valid?(@user.cookies.permanent["events_#{@record.id}_pincode"])
  end

  class Scope < Scope
  end
end
