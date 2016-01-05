Rails.application.routes.draw do

  root "kittens#index"
  resources :kittens
  
end
