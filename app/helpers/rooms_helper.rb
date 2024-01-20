# frozen_string_literal: true

module RoomsHelper
  def room_name_for_user(room, current_user)
    return 'Group chat' if room.is_common

    room.users.where.not(id: current_user.id).first&.name
  end
end
