# frozen_string_literal: true

Rails.application.routes.draw do
  get '/quickbooks/authorize', to: 'quickbooks#authorize'
  get '/quickbooks/callback', to: 'quickbooks#callback'

  devise_for :users

  resources :labels, :notes, :clients

  resources :activities do
    member do
      post :complete
      post :uncomplete
    end
  end

  resources :leads do
    collection do
      get :upload_csv
      post :process_csv
      post :mappings
    end
  end

  resources :users

  root 'clients#index'
end
