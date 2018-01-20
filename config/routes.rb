Rails.application.routes.draw do

  #Auth routes Devise/ActiveAdmin
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users

  #Ressources
  resources :users, only: :show
  resources :lessons
  post 'lessons/:id/pay', to: 'lessons#pay', as: 'pay_lesson'
  resources :payments



  # Static pages
  get  'home/index'
  post 'home/contact'
  root to: 'home#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
