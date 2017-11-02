Rails.application.routes.draw do

  devise_for :users
  #root 'devise/sessions#new'
  resources :users, only: [:show]

  devise_scope :user do
    authenticated :user do
      root 'users#index', as: :authenticated_root
    end

    unauthenticated do
      root 'devise/sessions#new', as: :unauthenticated_root
    end
  end
end
