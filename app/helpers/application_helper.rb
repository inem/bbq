module ApplicationHelper
  def user_avatar(user)
    user.avatar.variant(:medium) || asset_path('user.png')
  end

  def event_photo(event)
    photos = event.photos.persisted
  
    if photos.any?
      photos.sample.photo.url
    else
      asset_path('event.jpg')
    end
  end

  def event_thumb(event)
    photos = event.photos.persisted
  
    if photos.any?
      photos.sample.photo.thumb.url
    else
      asset_path('event_thumb.jpg')
    end
  end

  def user_avatar_thumb(user)
    user.avatar.variant(:thumb) || asset_path('user.png')
  end
end
