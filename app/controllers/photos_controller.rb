class PhotosController < ApplicationController
  before_action :set_event, only: [:create, :destroy]
  before_action :set_photo, only: [:destroy]

  def create
    @new_photo = @event.photos.build(photo_params)
    @new_photo.user = current_user
    @new_photo.tags = tags
    @new_photo.user_tags = params[:user_tags]

    if @new_photo.valid?
      PhotoService.create(@event, photo_params, current_user)

      redirect_to @event, notice: I18n.t("controllers.photos.created")
    else
      render "events/show", alert: I18n.t("controllers.photos.error")
    end
  end

  def destroy
    message = {notice: I18n.t("controllers.photos.destroyed")}

    if current_user_can_edit?(@photo)
      @photo.destroy
    else
      message = {alert: I18n.t("controllers.photos.error")}
    end

    redirect_to @event, message
  end

  private

  def set_event
    @event = Event.find(params[:event_id])
  end

  def set_photo
    @photo = @event.photos.find(params[:id])
  end

  def photo_params
    params.fetch(:photo, {}).permit(:photo)
  end
end
