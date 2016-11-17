Rails.application.routes.draw do

  root 'home#index'

  devise_for :users
  namespace :seller do
    resources :products
  end

  resources :shops, only: [:show] do
    resources :products, only: [:show]
  end

end
