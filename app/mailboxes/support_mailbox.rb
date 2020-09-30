class SupportMailbox < ApplicationMailbox
  before_processing :find_user

  def process
    return bounced! unless find_user

    SupportMailer.with(user: @user).auto_reply.deliver_later
  end

  private

  attr_reader :user
end
