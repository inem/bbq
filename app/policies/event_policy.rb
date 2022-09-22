class EventPolicy < ApplicationPolicy
  def create?
    user.present?
  end

  def edit?
    @record.user == @user.name_user
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
    true if @record.pincode.blank? || edit? || @record.pincode_valid?(@user.event_pincode)
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
