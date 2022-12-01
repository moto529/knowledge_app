Rails.application.routes.draw do
  root to: 'knowledges#timeline'
  devise_for :users, controllers: {
    registrations: "users/registrations",
  }
  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end

  resources :users, only: %i[show]
  resources :categories, only: %i[index show create]
  resources :knowledges, except: :edit do
    get 'timeline', on: :collection
  end
end
