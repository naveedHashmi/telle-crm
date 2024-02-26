# frozen_string_literal: true

Rails.application.routes.draw do

  devise_for :users

  resources :labels, :notes

  resources :deals do
    patch 'update_status', on: :member
  end

  resources :clients do
    collection do
      post :change_assignee
    end
  end

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
      post :change_assignee
    end
  end

  resources :users

  get '/analytics', to: 'analytics#analytics'
  root 'clients#index'
end
