class Matches::ChatChannel < ApplicationCable::Chanel

  def subscribed
    stream_from match_chat_channel
  end

  def speak
  end

  private

  def match_chat_channel
    "matches/#{id}/chat"
  end

  def id
    params[:id]
  end
end

