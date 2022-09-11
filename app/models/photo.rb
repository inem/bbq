class Photo < ApplicationRecord
  belongs_to :event
  belongs_to :user

  has_one_attached :photo do |attachable|
    attachable.variant :medium, resize_to_fit: [250, 250]
  end

  scope :persisted, -> { where "id IS NOT NULL" }
  validates :photo, presence: true
end
