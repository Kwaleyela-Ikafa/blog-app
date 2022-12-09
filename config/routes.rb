Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  # root :to => 'pages/home'
  # resources :users do
  #   resources :posts
  # end
  devise_scope :user do
    authenticated :user do
      root :to => 'users#index', as: :authenticated_root
    end
    unauthenticated :user do
      root :to => 'devise/registrations#new', as: :unauthenticated_root
    end
  end

  resources :users, only: [:index, :show] do
    resources :posts, only: [:index, :show, :create, :destroy]
  end

  resources :posts do
    resources :comments, only: [:create, :destroy]
    resources :likes, only: [:create]
  end
  
  # root 'pages#home'
  # Defines the root path route ("/")
  # root "articles#index"
end
