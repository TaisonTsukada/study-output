Rails.application.routes.draw do
  devise_for :users
  root to: "articles#index"
  resources :articles do
    resources :comments, only: [:create, :destroy]
  end
  post 'like/:id' => 'likes#create', as: 'create_like'
  delete 'like/:id' => 'likes#destroy', as: 'destroy_like'
  resources :users, only: [:show, :update, :edit]
end
