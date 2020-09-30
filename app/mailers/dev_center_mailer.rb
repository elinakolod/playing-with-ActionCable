class DevCenterMailer < ApplicationMailer
  default to: 'dev@mail.com',
          from: 'devcenter@chatter.org'

  def auto_reply
    @user = params[:user]
    mail(to: @user.email, subject: 'Auto Reply')
  end

  def admin_notification
    @title = params[:user_mail][:subject]
    @message = params[:user_mail][:text]
    @user = params[:user]
    mail(subject: 'User needs help')
  end
end
