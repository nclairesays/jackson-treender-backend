Rails.application.routes.draw do
  resources :matches
  resources :users
  
  resource :auth, only: [ :create ]

  
  post '/matches/check', to: 'matches#check_for_existing_entry'
  get '/user_matches', to: 'matches#user_matches'
  get '/get_potential_matchees', to: 'matches#get_potential_matchees'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
