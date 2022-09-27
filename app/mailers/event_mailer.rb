class EventMailer < ApplicationMailer
  def subscription(subscription)
    @email = subscription.user_email
    @name = subscription.author.name
    @event = subscription.event

    mail to: @event.user.email, subject: "#{I18n.t('event_mailer.new_subscriber')} #{@event.title}"
  end

  def comment(comment, email)
    @comment = comment
    @event = comment.event

    mail to: email, subject: "#{I18n.t('event_mailer.new_comment')} #{@event.title}"
  end

  def photo(photo, email)
    @photo = photo
    @event = photo.event

    mail to: email, subject: "#{I18n.t('event_mailer.new_photo')} #{@event.title}"
  end
end
