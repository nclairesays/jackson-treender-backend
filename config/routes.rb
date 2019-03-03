Rails.application.routes.draw do
  resources :matches
  resources :users
  
  resource :auth, only: [ :create ]

  
  post '/matches/check', to: 'matches#check_for_existing_entry'
  get '/successful_matches', to: 'matches#successful_matches'
  get '/get_potential_matchees', to: 'users#get_potential_matchees'
  get '/get_matchee_info', to: 'users#get_matchee_info'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
