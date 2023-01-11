Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root to: 'home#index'

  get 'users/sign_up', to: 'users#new'
  post 'users', to: 'users#create'
  get 'users/:id', to: 'users#show', as: 'account'
  get 'users/:id/edit', to: 'users#edit', as: 'edit_account'
  patch 'users/:id', to: 'users#update', as: 'update_account'
  put 'users/:id', to: 'users#update'
end
