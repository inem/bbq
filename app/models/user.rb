class User < ApplicationRecord
  after_commit :link_subscriptions, on: :create
  before_validation :set_name, on: :create
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable
  has_many :comments, dependent: :destroy
  has_many :events, dependent: :destroy
  has_many :subscriptions, dependent: :destroy

  has_one_attached :avatar do |attachable|
    attachable.variant :thumb, resize_to_fill: [30, 30]
    attachable.variant :medium, resize_to_fit: [400, 400]
  end

  validates :name, presence: true, length: {maximum: 35}

  private

  def set_name
    self.name = "Товарищ №#{rand(777)}" if self.name.blank?
  end

  def link_subscriptions
    Subscription.where(user_id: nil, user_email: self.email).update_all(user_id: self.id)
  end
end
