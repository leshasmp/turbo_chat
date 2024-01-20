# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Rooms' do
  describe 'GET /' do
    context 'when user is authorized' do
      let(:user) { create(:user) }
      let(:created_room) { Room.where(is_common: true).first }

      before do
        sign_in(user)
        get root_path
      end

      it 'create common room' do
        expect(created_room).to be_present
      end

      it 'redirect to common room page' do
        expect(response).to redirect_to(created_room)
      end
    end
  end

  describe 'rooms#show' do
    context 'when user is not authorized' do
      let!(:room) { create(:room) }

      it 'redirect to auth page' do
        get room_path(room)
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context 'when user is authorized' do
      let(:user) { create(:user) }
      let!(:room) { create(:room) }
      let!(:user_room) { create(:user_room, room:, user:) }

      before { sign_in(user) }

      it 'return room page' do
        get room_path(room)
        expect(response).to have_http_status(:ok)
      end
    end
  end

  describe 'rooms#create' do
    context 'when user is not authorized' do
      let!(:user) { create(:user) }
      let(:room_params) { { user_id: user.id } }

      it 'redirect to auth page' do
        post rooms_path
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context 'when user is authorized' do
      let(:user) { create(:user) }
      let(:created_room) { user.rooms.where(is_common: false).first }

      before do
        sign_in(user)
        post rooms_path, params: room_params
      end

      context 'when params is valid' do
        let(:room_params) { { user_id: user.id } }

        it 'create room' do
          expect(created_room).to be_present
        end

        it 'return room page' do
          expect(response).to redirect_to(created_room)
        end
      end

      context 'when params is invalid' do
        let(:room_params) { nil }

        it 'create room' do
          expect(created_room).to be_nil
        end

        it 'redirect to common room page' do
          expect(response).to redirect_to(user.rooms.where(is_common: true).first)
        end
      end
    end
  end
end
