# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'users' do
  describe 'devise/sessions#new' do
    it 'show sign in page' do
      get new_user_session_path
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'devise/sessions#destroy' do
    let(:user) { create(:user) }

    before { sign_in(user) }

    it 'sign out' do
      delete destroy_user_session_path
      expect(response).to redirect_to(root_path)
      expect(controller.current_user).to be_nil
    end
  end
end
