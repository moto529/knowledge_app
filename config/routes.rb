# frozen_string_literal: true

Rails.application.routes.draw do
  root to: 'knowledges#timeline'
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    omniauth_callbacks: 'omniauth_callbacks',
    omniauth_callbacks: 'users/omniauth_callbacks'
  }
  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end

  resources :users, only: %i[index show edit update] do
    resources :relationships, only: %i[create destroy]
    get 'profile', on: :member
    get 'followings' => 'relationships#followings'
    get 'followers' => 'relationships#followers'
    get :favorite, on: :collection
    get :result, on: :collection
  end
  resources :categories, only: %i[index show create]
  resources :knowledges do
    resources :comments, only: %i[new create edit update destroy]
    get 'timeline', on: :collection
  end
  resources :favorites, only: %i[create destroy]
  resources :notifications, only: :index
  
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
end
