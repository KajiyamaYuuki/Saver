Rails.application.routes.draw do
  get 'menus/index'
  get 'menus/new'
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  resources :users, only: [:index, :show]
  get 'home/index'
  root 'home#index'
  resources :conversations do
    resources :messages
  end
  resources :shops
  resources :staffs
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
