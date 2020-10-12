# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  # Execute `rails routes` for more details
  namespace :api do
    namespace :v1 do
      resources :todos do
        resources :items
      end
      resources :players
      post 'cockatiel', to: 'games#something'
    end
  end
end
