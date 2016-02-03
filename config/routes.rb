Rails.application.routes.draw do
  devise_for :users
  root to: "matches#index"
  resources :matches
  match '/websocket', to: ActionCable.server, via: [:get, :post]
end
