Rails.application.routes.draw do

  resources :collaborators

  resources :wikis

  resources :charges, only: [:new, :create]

  get 'downgrade' => 'charges#downgrade'

  devise_for :users
  get 'welcome/about'
  root 'welcome#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
