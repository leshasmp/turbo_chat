# frozen_string_literal: true

class MessagesController < ApplicationController
  def create
    room = current_user.rooms.find(params[:room_id])
    @message = current_user.messages.new(message_params.merge(room_id: room.id))

    if @message.save
      render turbo_stream: [append_message, update_form(room, room.messages.new)]
    else
      render turbo_stream: update_form(room, @message)
    end
  end

  private

  def message_params
    @message_params ||= params.require(:message).permit(:content)
  end

  def append_message
    turbo_stream.append(:messages, @message)
  end

  def update_form(room, message)
    turbo_stream.update(
      'new_message_form',
      partial: 'messages/new_message_form',
      locals: { room:, message: }
    )
  end
end
