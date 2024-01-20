# frozen_string_literal: true

# rubocop:disable Rails/LexicallyScopedActionFilter
module Users
  class RegistrationsController < Devise::RegistrationsController
    before_action :configure_sign_up_params, only: [:create]

    protected

    def configure_sign_up_params
      devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:name, :email, :password) }

      devise_parameter_sanitizer.permit(:account_update) do |u|
        u.permit(:name, :email, :password, :current_password)
      end
    end
  end
end
# rubocop:enable Rails/LexicallyScopedActionFilter
