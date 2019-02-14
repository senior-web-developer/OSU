Rails.application.routes.draw do
  root :to => 'dashboard#index'
  mount ShopifyApp::Engine, at: '/'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  #root 'dashboard#index'
  get 'home/index'
  get 'dashboard/index'
  
  post 'orders/create'
  patch 'orders/update'
  get 'orders/update'
  
  resources :orders
end
