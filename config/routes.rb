Rails.application.routes.draw do
  # get 'likes/create'
  # get 'likes/destroy'
  # get 'likes/like_params'

  resources :likes, only: [:create, :destroy]

  # get 'users/show'
  resources :comments

  devise_scope :user do
    get '/users', to: 'devise/registerations#new'
    get '/users/password', to: 'devise/passwords#new'
    get '/users/sign_out' => 'devise/sessions#destroy'
  end
  # devise_for :users

  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }

  resources :users, only: [:show]

  get 'home/about'
  get 'posts/myposts'
  resources :posts
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "posts#index"
end
