Rails.application.routes.draw do

  root 'home#index'

  devise_for :users
  namespace :seller do
    resource :shop, only: [:show, :create]
    resources :products, except: [:show]
  end

  resources :shops, only: [] do
    resources :products, only: [:index, :show]
    resources :cart_items, only: [:create, :destroy]
    resource :cart, only: [:show, :update]
    resources :orders, only: [:new, :create, :show]
  end


end
