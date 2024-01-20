# frozen_string_literal: true

class RoomsController < ApplicationController
  before_action :find_exist_room, only: %i[create]

  helper RoomsHelper

  def show
    add_user_to_common_room

    @room = current_user.rooms.find_by(id: params[:id])

    if @room.nil?
      redirect_to current_user.rooms.first
      return
    end

    @users = User.all_except(current_user)
    @message = @room.messages.new
  end

  def create
    user = User.find(params[:user_id])
    room = Room.new(users: [current_user, user])

    if room.save
      redirect_to room_path(room)
    else
      flash[:error] = room.errors.full_messages.join(', ')
      redirect_to rooms_path
    end
  end

  private

  def find_exist_room
    user = User.find_by(id: params[:user_id])

    if user.nil?
      redirect_to rooms_path
      return
    end

    found_room = Room.where(is_common: false).where(id: current_user.rooms.ids & user.rooms.ids).first

    redirect_to room_path(found_room) if found_room
  end

  def add_user_to_common_room
    @common_room = Room.find_or_create_by(is_common: true)

    return @common_room if current_user.rooms.exists?(is_common: true)

    @common_room.users << current_user
    @common_room.save

    @common_room
  end
end
