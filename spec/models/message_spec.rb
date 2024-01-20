# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Message do
  describe 'associations' do
    it 'belongs_to room' do
      association = described_class.reflect_on_association(:room)
      expect(association.macro).to eq :belongs_to
    end

    it 'belongs_to user' do
      association = described_class.reflect_on_association(:user)
      expect(association.macro).to eq :belongs_to
    end
  end

  describe 'callbacks' do
    let(:message) { build(:message) }

    before do
      allow(message).to receive(:broadcast_append_to)
    end

    it 'calls broadcast_append_to after create_commit' do
      message.save
      expect(message).to have_received(:broadcast_append_to).once
    end
  end

  describe 'validations' do
    it 'content to be presence' do
      expect(described_class.new(content: nil)).not_to be_valid
    end
  end
end
