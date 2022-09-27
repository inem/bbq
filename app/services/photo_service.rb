class PhotoService
  def self.create(event, photo_params, user)
    new_photo = PhotoMutator.create(event, photo_params, user)

    AiPhotoTaggerJob.perform_later(photo.id)
    PhotoMailSenderJob.perform_later(event, new_photo)
    PhotoSlackSenderJob.perform_later(event, new_photo)
    new_photo
  end

  def self.publish(photo)
    photo.update(
      status: :published,
      published_at: DateTime.current
    )

    PhotoPublishedSlackSenderJob.perform_later(photo)
    photo
  end
end