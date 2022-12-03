Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  # root :to => 'pages/home'
  # resources :users do
  #   resources :posts
  # end

  resources :users, only: [:index, :show] do
    resources :posts, only: [:index, :show, :create]
  end

  resources :posts do
    resources :comments, only: [:create]
    resources :likes, only: [:create]
  end
  
  root 'pages#home'
  # Defines the root path route ("/")
  # root "articles#index"
end
