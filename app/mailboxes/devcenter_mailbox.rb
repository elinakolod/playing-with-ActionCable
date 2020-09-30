class DevcenterMailbox < ApplicationMailbox
  before_processing :find_user

  def process
    return bounced! unless user

    fetch_content(user_mail: mail)
    notify_admin
    reply_to_user
  end

  private

  attr_reader :user, :message

  def fetch_content(user_mail:)
    @message = Support::ExtractEmailContent.new(mail: user_mail).call
  end

  def notify_admin
    DevCenterMailer.with(user_mail: message, user: user).admin_notification.deliver_later
  end

  def reply_to_user
    DevCenterMailer.with(user: user).auto_reply.deliver_later
  end
end
