class PhotoMutator
  def self.create(event, photo_params, user)
    new_photo = event.photos.build(photo_params)
    new_photo.user = user
    new_photo.user_tags = TagMutator.create_from_string(photo_params[:user_tags])
    new_photo.location = Location.find_or_create(photo_params[:lat],params[:lng])

    new_photo.tags = tags
    new_photo.save!
    new_photo
  end
end
