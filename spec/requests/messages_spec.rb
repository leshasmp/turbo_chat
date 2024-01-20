# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Messages' do
  describe 'messages#create' do
    context 'when user is not authorized' do
      let!(:user) { create(:user) }
      let!(:room) { create(:room) }
      let!(:user_room) { create(:user_room, room:, user:) }

      let(:message_params) do
        {
          message: {
            content: Faker::Lorem.sentence
          }
        }
      end

      before do
        post room_messages_path(room), params: message_params
      end

      it 'redirect to auth page' do
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context 'when user is authorized' do
      context 'when params is valid' do
        let!(:user) { create(:user) }
        let!(:room) { create(:room) }
        let!(:user_room) { create(:user_room, room:, user:) }
        let(:created_message) { room.messages.first }

        let(:message_params) do
          {
            message: {
              content: Faker::Lorem.sentence
            }
          }
        end

        before do
          sign_in(user)
          post room_messages_path(room), params: message_params
        end

        it 'create message' do
          expect(created_message).to be_present
        end

        it 'return rooms page' do
          expect(response).to have_http_status(:ok)
        end
      end

      context 'when params is invalid' do
        let(:user) { create(:user) }
        let!(:room) { create(:room) }
        let!(:user_room) { create(:user_room, room:, user:) }
        let(:created_message) { room.messages.find_by(content: message_params[:message][:content]) }

        let(:message_params) do
          {
            message: {
              content: nil
            }
          }
        end

        before do
          sign_in(user)
          post room_messages_path(room), params: message_params
        end

        it 'create message' do
          expect(created_message).to be_nil
        end

        it 'return rooms page' do
          expect(response).to have_http_status(:ok)
        end
      end
    end
  end
end
