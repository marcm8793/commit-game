Rails.application.routes.draw do
  # get 'messages/create'
  # get 'chatrooms/show'
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  root to: "pages#index"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"

  resources :arenas, only: [:create, :new, :show, :index] do
    resources :projects, only: [:create, :new, :show, :index]
    resources :tasks, only: [:create, :new, :show, :index]
    resource :chatroom, only: [:show] do
      resources :messages, only: [:create]
    end
  end
end
