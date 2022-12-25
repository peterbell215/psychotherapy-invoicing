Rails.application.routes.draw do
  resources :clients

  root 'home#index'
end
