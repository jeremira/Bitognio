Rails.application.routes.draw do

  #Auth routes Devise/ActiveAdmin
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users

  #Ressources
  resources :users, only: :show
  resources :lessons
  resources :payments

  post 'lessons/:id/pay',     to: 'lessons#pay',     as: 'pay_lesson'
  post 'lessons/:id/approve', to: 'lessons#approve', as: 'approve_lesson'

  # Static pages
  get  'home/index'
  post 'home/contact'
  root to: 'home#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
