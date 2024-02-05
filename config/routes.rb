# frozen_string_literal: true

Rails.application.routes.draw do
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

  resources :users, only: %i[new create edit update destroy]

  root 'clients#index'
end
