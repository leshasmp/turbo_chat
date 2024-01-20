# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Room do
  describe 'associations' do
    it 'has many messages with dependent destroy' do
      association = described_class.reflect_on_association(:messages)
      expect(association.macro).to eq :has_many
      expect(association.options).to include(dependent: :destroy)
    end

    it 'has many user_rooms with dependent destroy' do
      association = described_class.reflect_on_association(:user_rooms)
      expect(association.macro).to eq :has_many
      expect(association.options[:dependent]).to eq :destroy
    end

    it 'has many users through user_rooms' do
      association = described_class.reflect_on_association(:users)
      expect(association.macro).to eq :has_many
      expect(association.options[:through]).to eq :user_rooms
    end
  end

  describe 'scopes' do
    let!(:room_fist) { create(:room) }
    let!(:room_second) { create(:room) }

    it 'defines all_except scope' do
      expect(described_class.all_except(room_fist)).to include(room_second)
      expect(described_class.all_except(room_fist)).not_to include(room_fist)
    end
  end
end
