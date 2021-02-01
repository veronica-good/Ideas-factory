Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'ideas#index'
  resources :ideas
  # Session Routes
  resource :session, only: [:new, :create, :destroy]
  # User Routes
  resources :users, only:[:new, :create]
end
