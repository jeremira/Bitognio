Rails.application.routes.draw do

  #Auth routes Devise/ActiveAdmin
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users

  #Ressources
  resources :users, only: :show do
    resources :payments
  end

  # Static pages
  get 'home/index'
  root to: 'home#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
