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
    resources :documents do
      member do
        get :update_envelope_id
      end
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

  get 'docusign/success', to: 'docusign#success'
  get 'docusign/token', to: 'docusign#token'
  get 'docusign/authenticate', to: 'docusign#authenticate'
  get 'docusign/template', to: 'docusign#template'

  get '/analytics', to: 'analytics#analytics'
  delete '/sessions/sign_out', to: 'devise/sessions#destroy'
  get 'authenticate', to: 'gmail#authenticate'
  get 'auth/success', to: 'gmail#success'
  root 'clients#index'
end
