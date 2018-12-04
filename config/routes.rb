Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users, path_names: { sign_in: 'login', sign_out: 'logout', sign_up: 'register' }
  resources :books, only: [:index, :show] do
    collection do
      get 'recomendations'
      get 'best'
    end
    member do
      post 'like'
      post 'dislike'
    end
  end
  resources :reviews, only: [:index, :create]
  root 'books#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
