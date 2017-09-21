class PinsChannel < ApplicationCable::Channel
  def subscribed
    stream_from "pins_#{params['pin_id']}_channel"
  end

  def unsubscribed
  end

  def send_comment(data)
    current_user.comments.create!(content: data['comment'], pin_id: data['pin_id'])
  end
end
