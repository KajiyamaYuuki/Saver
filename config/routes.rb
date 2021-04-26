Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  resources :users, only: [:show]
  resources :conversations do
    resources :messages
  end
  resources :shops do
    resources :reviews, only: [:index, :create]
  end
  resources :staffs
  resources :menus do
    resources :reservations, only: [:index, :new, :create, :destroy]
  end
  root 'shops#index'
end
