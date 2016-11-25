Rails.application.routes.draw do

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

  constraints lambda { |req| req.subdomain.blank? } do
    namespace :seller do
      resource :shop, only: [:show, :update]
      resources :products, except: [:show]
      resources :orders, only: [:index, :edit, :update]
    end
  end

  constraints lambda { |req| req.subdomain.present? } do
    resources :products, only: [:index, :show]
    resources :cart_items, only: [:create, :destroy]
    resource :cart, only: [:show, :update]
    resources :orders, only: [:new, :create, :show], param: :token do
      post :pay2go_return,   on: :member
      post :pay2go_customer, on: :member
      post :pay2go_notify,   on: :member
    end
    get '/', to: 'products#index'
  end
  root 'home#index'

end
