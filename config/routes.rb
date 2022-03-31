# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :admin do
    resources :users
    resources :charts

    root to: "users#index"
  end

  devise_for :users

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  resources :charts do
    resources :likes, only: :create
    resources :karma_votes, only: %i[create update]
    resources :comments, only: %i[create edit update delete]
  end

  # Defines the root path route ("/")
  root "charts#index"
end
