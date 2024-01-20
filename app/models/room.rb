# frozen_string_literal: true

class Room < ApplicationRecord
  has_many :messages, dependent: :destroy
  has_many :user_rooms, dependent: :destroy
  has_many :users, through: :user_rooms

  scope :all_except, ->(room) { where.not(id: room) }
end
