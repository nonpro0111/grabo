Admin::Engine.routes.draw do
  devise_for :users, class_name: "Admin::User", module: :devise, controllers: {sessions: "admin/sessions"}
  resources :videos
  resources :home, only: :index

  root "home#index"
end
