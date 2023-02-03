Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root to: 'home#index'

  resource :user, only: %i[new create], path_names: { new: 'sign_up' } do
    resource :account, only: %i[show edit update], controller: 'users'
    resource :profile, only: %i[show edit update], controller: 'users/profiles'
  end

  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  resources :rooms, except: :destroy do
    get :registrations, on: :collection, controller: 'rooms/registrations', action: 'index'
  end
end
