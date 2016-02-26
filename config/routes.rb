Rails.application.routes.draw do

  root 'users#show'
  devise_for :users
  resources :users, only: :show
  resources :groups, only: [:show, :edit, :new, :create, :update, :destroy] do
    collection do
      post 'pushercreate'
    end
  end



end