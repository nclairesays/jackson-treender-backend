Rails.application.routes.draw do
  resources :matches
  resources :users

  get '/matches/check', to: 'matches#check_entries'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
