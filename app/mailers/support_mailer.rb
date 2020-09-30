class SupportMailer < ApplicationMailer
  default from: 'support@chatter.org'

  def auto_reply
    @user = params[:user]
    @faqs = Faq.all
    mail(to: @user.email, subject: 'Auto Reply')
  end
end
