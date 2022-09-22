class MailSenderJob < ApplicationJob
  queue_as :default

  def perform_subscription_mail(subscription)
    EventMailer.subscription(subscription).deliver_now
  end

  def perform_comment_mail(comment, mail)
    EventMailer.comment(comment, mail).deliver_now
  end

  def perform_photo_mail(photo, mail)
    EventMailer.photo(photo, mail).deliver_now
  end

  def perform_registration_mail(user)
    UserMailer.registration(user).deliver_now
  end
end
