Rails.application.routes.draw do
  resources :homes
  devise_for :users

  get '/users/auth/:provider/callback' => 'homes#social_login'
  get '/users/auth/failure' => 'homes#social_failure'

  root to: 'homes#index'
end
