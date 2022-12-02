Rails.application.routes.draw do
  get 'relationships/followings'
  get 'relationships/followers'
  root to: 'knowledges#timeline'
  devise_for :users, controllers: {
    registrations: "users/registrations",
  }
  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end

  resources :users, only: %i[show] do
    resources :relationships, only: [:create, :destroy]
    get 'followings' => 'relationships#followings', as: 'followings'
    get 'followers' => 'relationships#followers', as: 'followers'
  end
  resources :categories, only: %i[index show create]
  resources :knowledges, except: :edit do
    get 'timeline', on: :collection
  end
end
