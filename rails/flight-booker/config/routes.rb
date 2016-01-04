Rails.application.routes.draw do

  root 'flights#index'
  resources :flights, only: [:index]
  resources :bookings, only: [:new, :create, :show]

end
