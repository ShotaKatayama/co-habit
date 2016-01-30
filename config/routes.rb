Rails.application.routes.draw do

  root 'users#show'
  devise_for :users
  resources :users, only: [:show, :create] do
    resources :groups, only: [:show, :new, :edit]
  end

end
