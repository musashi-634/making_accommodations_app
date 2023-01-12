Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root to: 'home#index'

  resources :users, except: %i[index destroy], path_names: { new: 'sign_up' } do
    resource :profile, only: %i[show edit update], controller: 'users/profiles'
  end
end
