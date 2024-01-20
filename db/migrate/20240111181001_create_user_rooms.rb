# frozen_string_literal: true

class CreateUserRooms < ActiveRecord::Migration[7.1]
  def change
    create_table :user_rooms do |t|
      t.references :user, null: false, foreign_key: true, index: true
      t.references :room, null: false, foreign_key: true, index: true

      t.timestamps
    end
  end
end
