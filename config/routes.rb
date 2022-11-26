Rails.application.routes.draw do
  root to: 'knowledges#timeline'
  devise_for :users
  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end
  
  resources :categories, only: %i[index create]
  resources :knowledges, only: %i[index new create show update destroy] do
    get 'timeline', on: :collection
  end
end
