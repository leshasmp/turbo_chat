# frozen_string_literal: true

class CreateRooms < ActiveRecord::Migration[7.1]
  def change
    create_table :rooms do |t|
      t.boolean :is_common, default: false

      t.timestamps
    end
  end
end
