Rails.application.routes.draw do

  devise_for :users, controllers: { registrations: 'registrations' }
  
  resources :users, only: [:show]

  get '/users/:id/photos', to: 'users#photo', as: 'photo'

  devise_scope :user do
    authenticated :user do
      root 'users#show', as: :authenticated_root
    end

    unauthenticated do
      root 'devise/sessions#new', as: :unauthenticated_root
    end
  end
end
