Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'registrations' }
  
  resources :users, only: [:show, :index]
  resources :friend_requests
  resources :friendships, only: [:destroy]

  get '/users/:id/photos', to: 'users#photo', as: 'photo'
  get '/users/:id/friends', to: 'users#friends', as: 'friends'

  devise_scope :user do
    authenticated :user do
      root 'users#show', as: :authenticated_root
    end

    unauthenticated do
      root 'devise/sessions#new', as: :unauthenticated_root
    end
  end
end
