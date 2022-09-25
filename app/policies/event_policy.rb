class EventPolicy < ApplicationPolicy
  def owner?
    @record.user == @user
  end

  def create?
    user.present?
  end

  def edit?
    owner?
  end

  def destroy?
    owner?
  end
  
  def show?
    password_guard
  end
  
  def update?
    owner?
  end

  private

  def password_guard
    @record.pincode.blank? || owner? || @record.pincode_valid?(@cookies&.permanent&["events_#{@record.id}_pincode"])
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
