# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Users::Registrations' do
  describe 'users/registrations#create' do
    context 'when params is valid' do
      let(:user_params) do
        {
          user: {
            name: Faker::Name.first_name,
            email: Faker::Internet.email,
            password: 'password',
            password_confirmation: 'password'
          }
        }
      end
      let(:created_user) { User.find_by(email: user_params[:user][:email]) }

      before { post user_registration_path, params: user_params }

      it 'redirect to rooms' do
        expect(response).to redirect_to(root_path)
      end

      it 'create user' do
        expect(created_user).to be_present
      end
    end

    context 'when params is invalid' do
      let(:user_params) do
        {
          user: {
            name: Faker::Name.first_name
          }
        }
      end

      before { post user_registration_path, params: user_params }

      it 'return 422' do
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end
