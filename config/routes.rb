Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations'
      }
  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#new_guest'
  end

  root to: "articles#index"
  resources :articles do
    resources :comments, only: [:create, :destroy]
    collection do
      get 'tag_list'
    end
  end
  
  post 'like/:id' => 'likes#create', as: 'create_like'
  delete 'like/:id' => 'likes#destroy', as: 'destroy_like'

  resources :users, only: [:show] do
    get :followings, on: :member
    get :followers, on: :member
  end
  resources :relationships, only: [:create, :destroy]

  resources :messages, only: [:create]
  resources :rooms, only: [:index, :create,:show]



  resources :notifications, only: :index
  resources :activities, only: :index

  resources :stocks, only: [:index, :create, :destroy]
  mount ActionCable.server => '/cable'
end
