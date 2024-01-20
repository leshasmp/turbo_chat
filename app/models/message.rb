# frozen_string_literal: true

class Message < ApplicationRecord
  belongs_to :room
  belongs_to :user

  after_create_commit { broadcast_append_to room }

  validates :content, presence: true
end
