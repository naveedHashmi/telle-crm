# frozen_string_literal: true

Rails.application.routes.draw do
  resources :activities
  resources :leads
  resources :clients
  resources :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root 'clients#index'
end
