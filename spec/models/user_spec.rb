# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User do
  describe 'associations' do
    it 'has many messages with dependent destroy' do
      association = described_class.reflect_on_association(:messages)
      expect(association.macro).to eq :has_many
      expect(association.options[:dependent]).to eq :destroy
    end

    it 'has many user_rooms with dependent destroy' do
      association = described_class.reflect_on_association(:user_rooms)
      expect(association.macro).to eq :has_many
      expect(association.options[:dependent]).to eq :destroy
    end

    it 'has many rooms through user_rooms' do
      association = described_class.reflect_on_association(:rooms)
      expect(association.macro).to eq :has_many
      expect(association.options[:through]).to eq :user_rooms
    end
  end

  describe 'callbacks' do
    let(:user) { build(:user) }

    before do
      allow(user).to receive(:broadcast_append_to)
    end

    it 'calls broadcast_append_to after create_commit' do
      user.save
      expect(user).to have_received(:broadcast_append_to).once
    end
  end

  describe 'scopes' do
    let!(:user) { create(:user) }
    let!(:user_second) { create(:user) }

    it 'defines all_except scope' do
      expect(described_class.all_except(user)).to include(user_second)
      expect(described_class.all_except(user)).not_to include(user)
    end
  end

  describe 'validations' do
    let!(:user) { create(:user) }

    it 'email to be presence' do
      expect(build(:user, email: nil)).not_to be_valid
    end

    it 'name to be presence' do
      expect(build(:user, name: nil)).not_to be_valid
    end

    it 'password to be presence' do
      expect(build(:user, password: nil)).not_to be_valid
    end

    it 'email to be uniqless' do
      expect(build(:user, email: user.email)).not_to be_valid
    end

    it 'name to be uniqless' do
      expect(build(:user, email: user.name)).not_to be_valid
    end
  end
end
