class Photo < ApplicationRecord
  belongs_to :event
  belongs_to :user

  has_one_attached :photo do |attachable|
    attachable.variant :medium, resize_to_fit: [250, 250]
  end

  scope :persisted, -> { where "id IS NOT NULL" }
  validates :photo, presence: true

  # after_save :fill_tags_by_ai
  # after_save :send_to_slack, if: -> { }
  # before_validate :fill_tags, if: -> { }

  def fill_tags_by_ai
    AiPhotoTaggerJob.perform_later(photo.id)
  end
end
