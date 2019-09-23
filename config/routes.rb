Rails.application.routes.draw do
  get 'home/new'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :ideas
  resources :ideas do
    resources :reviews, only: [:create, :destroy]
    resources :likes, only: [:create, :destroy]
  end

  resources :users, only: [:new, :create]
  resource :session, only: [:new, :create, :destroy]

  get '/', to: "home#new"
end
