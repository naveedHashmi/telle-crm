# frozen_string_literal: true

Rails.application.routes.draw do
  resources :users, only: %i[index new create edit update]
  resources :invoice_queues do
    member do
      patch :approve
    end
  end
  resources :deals
  devise_for :users

  resources :labels, :notes

  resources :deals do
    patch 'update_status', on: :member
  end

  resources :clients do
    collection do
      post :change_assignee
    end

    member do
      get :emails
    end

    resources :emails, only: %i[show]
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

  get '/analytics', to: 'analytics#analytics'
  delete '/sessions/sign_out', to: 'devise/sessions#destroy'
  get 'authenticate', to: 'gmail#authenticate'
  get 'auth/success', to: 'gmail#success'
  root 'clients#index'
end
