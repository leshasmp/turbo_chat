# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations' }

  resources :rooms, only: %i[create show] do
    resources :messages, only: %i[create]
  end

  root 'rooms#show'
end
