Rails.application.routes.draw do
  resources :photos
  resources :subscriptions
  root to: "events#index"
  devise_for :users

  resources :events do
    resources :comments, only: [:create, :destroy]
    resources :subscriptions, only: [:create, :destroy]
    resources :photos, only: [:create, :destroy]
  end

  resources :users, only: [:show, :edit, :update]
end
