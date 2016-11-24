Rails.application.routes.draw do

  root 'home#index'

  devise_for :users
  namespace :seller do
    resource :shop, only: [:show, :create, :update]
    resources :products, except: [:show]
    resources :orders, only: [:index, :edit, :update]
  end

  resources :shops, only: [] do
    resources :products, only: [:index, :show]
    resources :cart_items, only: [:create, :destroy]
    resource :cart, only: [:show, :update]
    resources :orders, only: [:new, :create, :show], param: :token do
      post :pay2go_return,   on: :member
      post :pay2go_customer, on: :member
      post :pay2go_notify,   on: :member
    end
  end


end
