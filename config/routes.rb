Rails.application.routes.draw do
  devise_for :users
  
  root to: "homes#top"
  get 'home/about' => 'homes#about'
  get "/search", to: "searches#search"
  get 'tagsearches/search', to: 'tagsearches#search'
  
  #patch 'books/:id' => "books#edit", as: "edit"
  resources :books, only: [:create, :index, :show, :destroy, :edit, :update] do
        resource :favorite, only: [:create, :destroy]
        resources :book_comments, only: [:create]
  end
  resources :book_comments, only: [:destroy]
  
  resources :users, only: [:index, :show, :edit, :update] do
        resource :relationships, only: [:create, :destroy]
      	get "followings" => "relationships#followings", as: "followings"
  	    get "followers" => "relationships#followers", as: "followers"
  end
  
  resources :notifications, only: [:update]
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  #get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end