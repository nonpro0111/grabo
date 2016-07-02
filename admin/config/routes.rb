Admin::Engine.routes.draw do
  devise_for :users, class_name: "Admin::User", module: :devise
  resources :videos

  root "admin/sessions#new"
end
