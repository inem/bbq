class EventPolicy < ApplicationPolicy
  def create?
    user.present?
  end

  def edit?
    @record.user == @user&.user
  end

  def destroy?
    edit?
  end
  
  def show?
    password_guard
  end
  
  def update?
    edit?
  end

  private

  def password_guard
    return true if @record.pincode.blank? || edit? ||
      @record.pincode_valid?(@user.cookies.permanent["events_#{@record.id}_pincode"])
  
    if @user.pincode.present? && @record.pincode_valid?(@user.pincode)
      @user.cookies.permanent["events_#{@record.id}_pincode"] = @user.pincode
    end
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
