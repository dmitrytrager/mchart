# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :admin do
    resources :users

    root to: "users#index"
  end

  devise_for :users

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  resources :charts

  # Defines the root path route ("/")
  root "charts#index"
end
