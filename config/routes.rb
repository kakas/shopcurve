Rails.application.routes.draw do

  namespace :seller do
    resources :products
  end

  resources :shops, only: [:show] do
    resources :products, only: [:show]
  end

end
