require 'sidekiq/web'

Rails.application.routes.draw do
  devise_for :users
  root 'conversations#index'

  mount Sidekiq::Web => '/sidekiq'

  resources :users, only: [:index]
  resources :personal_messages, only: [:new, :create, :show]
  resources :conversations, only: [:index, :show]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
