class RoomChannel < ApplicationCable::Channel
  def subscribed
    binding.pry
    stream_from "room_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def speak(data)
    Message.create!(content: data['message']) 
    ActionCable.server.broadcast 'room_channel', data['message']
  end
end
