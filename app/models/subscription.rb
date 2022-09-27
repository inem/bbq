class Subscription < ApplicationRecord
  belongs_to :event
  belongs_to :user, optional: true

  validates :user_name, presence: true, unless: -> { user.present? }

  with_options unless: -> { user.present? } do
    validates :user_email, presence: true, format: /\A[\w\-.]+@[\w\-.]+\z/, uniqueness: {scope: :event_id}
    validate :email_is_busy
  end

  with_options if: -> { user.present? } do
    validates :user, uniqueness: {scope: :event_id}
    validate :is_owner_error_check
  end

  def author
    UserTypes.init(self)
  end

  def is_owner_error_check
    errors.add(:user_id, :is_owner, message: I18n.t('controllers.subscriptions.self_sub')) if user == event.user
  end

  def email_is_busy
    if User.where(email: user_email).present?
      errors.add(:user_email, :is_busy, message: I18n.t('controllers.subscriptions.email_is_busy'))
    end
  end
end

