Rails.application.routes.draw do
  devise_for :users, controllers: {
        sessions: 'users/sessions'
      }
  root to: "articles#index"
  resources :articles do
    resources :comments, only: [:create, :destroy]
    collection do
      get 'search'
      get 'rank_index'
    end
  end
  
  post 'like/:id' => 'likes#create', as: 'create_like'
  delete 'like/:id' => 'likes#destroy', as: 'destroy_like'
  resources :users, only: [:show, :update, :edit] do
    get :followings, on: :member
    get :followers, on: :member
  end

  resources :relationships, only: [:create, :destroy]
  resources :notifications, only: :index
  resources :activities, only: :index
  resources :stocks, only: [:index, :create, :destroy]
end
