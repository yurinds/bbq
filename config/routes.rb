# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_for :users

  root 'events#index'

  resources :events do
    resources :comments, only: %i[create destroy]
    resources :subscriptions, only: %i[create destroy]
  end

  resources :users, only: %i[show edit update]
end
