Rails.application.routes.draw do
  devise_for :users
  root to: "matches#index"
  resources :matches do
    resources :chat, only: [:index], controller: 'matches/chat'
    resources :moves, only: [:index], controller: 'matches/moves'
  end
end
