class ApplicationMailbox < ActionMailbox::Base
  routing 'support@chatter.org' => :support
  routing 'devcenter@chatter.org' => :devcenter

  def find_user
    @user = User.find_by(email: mail.from)
  end
end
