Rails.application.routes.draw do
  resources :posts
#  get 'about' => 'welcome#about'
  root to: 'welcome#index'
  root to: 'posts#index'

  devise_for :users
  resources :wikis

  resources :users, only: [:update]

end
