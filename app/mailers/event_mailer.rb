class EventMailer < ApplicationMailer
  def subscription(event, subscription)
    @email = subscription.user_email
    @name = subscription.user_name
    @event = event
  
    mail to: event.user.email, subject: "#{I18n.t('event_mailer.new_subscriber')} #{event.title}"
  end

  def comment(event, comment, email)
    @comment = comment
    @event = event
  
    mail to: email, subject: "#{I18n.t('event_mailer.new_comment')} #{event.title}"
  end

  def photo(event, photo, email)
    @photo = photo
    @event = event
  
    mail to: email, subject: "#{I18n.t('event_mailer.new_photo')} #{event.title}"
  end
end
