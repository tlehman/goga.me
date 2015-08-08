Rails.application.routes.draw do
  devise_for :users
  root to: "matches#index"
  resources :matches
end
