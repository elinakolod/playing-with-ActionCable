class NotifierChannel < ApplicationCable::Channel
  def subscribed
    stream_from("notifier_#{current_user.id}_channel")
  end
end
