class RoomChannel < ApplicationCable::Channel
  def subscribed
    stream_from params[:channel].underscore
  end
end
