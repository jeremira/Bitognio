Rails.application.routes.draw do

  #Auth routes Devise/ActiveAdmin
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users

  #Ressources
  resources :users,     only: :show
  resources :careers,   only: [:index, :new, :create]
  resources :payments

  resources :lessons
  post 'lessons/:id/pay',     to: 'lessons#pay',     as: 'pay_lesson'
  post 'lessons/:id/approve', to: 'lessons#approve', as: 'approve_lesson'

  resources :postits, only: [:index, :create, :destroy]

  # Static pages
  get  'home/index'
  post 'home/contact'
  root to: 'home#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
