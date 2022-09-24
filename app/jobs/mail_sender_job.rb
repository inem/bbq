class MailSenderJob < ApplicationJob
  queue_as :default

  def perform_subscription_mail(subscription)
    EventMailer.subscription(subscription).deliver_later
  end

  def perform_comment_mail(event, comment)
    all_emails = (event.subscriptions.map(&:user_email) + [event.user.email] - [comment.user&.email]).uniq
    all_emails.each { |mail| EventMailer.comment(comment, mail).deliver_later }
  end

  def perform_photo_mail(event, photo)
    all_emails = (event.subscriptions.map(&:user_email) + [event.user.email] - [photo.user.email]).uniq
    all_emails.each { |mail| EventMailer.photo(photo, mail).deliver_later }
  end

  def perform_registration_mail(user)
    UserMailer.registration(user).deliver_later
  end
end
