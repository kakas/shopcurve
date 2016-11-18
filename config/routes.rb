Rails.application.routes.draw do

  root 'home#index'

  devise_for :users
  namespace :seller do
    resource :shop, only: [:show, :create]
    resources :products, except: [:show]
  end

  resources :shops, only: [] do
    resources :products, only: [:index, :show]
  end

end
