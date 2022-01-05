Rails.application.routes.draw do
  root to: 'pages#home'

  devise_for :users

  resources :events do
    resources :sessions do
      resources :bookings, only: [:new, :create, :show, :destroy]
    end
  end
  post 'create-payment-intent', to: 'bookings#create_payment_intent'

  resources :reviews
  resources :bookings, only: [:index]

  get 'new-to-unwind', to: 'pages#new_to_unwind'
  get 'cleanliness', to: 'pages#cleanliness'
  get 'studio', to: 'pages#studio'
  get 'resources', to: 'pages#resources'
  get 'rules', to: 'pages#rules'

  get 'home', to: 'admin#home'
  get 'schedule', to: 'admin#schedule'
end
