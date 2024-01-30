# frozen_string_literal: true

Rails.application.routes.draw do
  resources :labels
  resources :notes
  resources :activities
  resources :leads do
    collection do
      get :upload_csv
      post :process_csv
      post :mappings
    end
  end
  resources :clients
  resources :users
  root 'clients#index'
end
