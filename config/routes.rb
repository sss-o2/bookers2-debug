Rails.application.routes.draw do
  devise_for :users

  resources :users,only: [:show,:index,:edit,:update] do
  	member do
  		get :following, :followers
  	end
    collection do
      get :search
    end
  end

  resources :relationships, only: [:create, :destroy]
  
  resources :books do
  	resource :favorites, only: [:create, :destroy]
  	resources :book_comments, only: [:create, :destroy]
    collection do
      get :search
    end
  end

  get "search" => "search#search"
  root 'home#top'
  get 'home/about'
 end
