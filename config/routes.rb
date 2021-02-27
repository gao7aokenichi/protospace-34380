Rails.application.routes.draw do
  devise_for :users
  root to: "prototypes#index"
  # resourcesでアクションへのルーティングを自動生成
  resources :prototypes, only: [:new, :create, :show, :edit, :update, :destroy] do
    resources :comments, only: :create 
  end
  resources :users, only: :show
end
