Rails.application.routes.draw do
  root "home#index"
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  resources :push_subscriptions, only: [:index, :create, :destroy]
  post "/notification_delivered", to: "notification_callbacks#notification_delivered"
  post "/notification_clicked", to: "notification_callbacks#notification_clicked"
end
