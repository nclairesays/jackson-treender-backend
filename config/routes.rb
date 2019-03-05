Rails.application.routes.draw do
  resources :matches
  resources :users
  
  resource :auth, only: [ :create ]

  
  post '/matches/check', to: 'matches#check_for_existing_entry'
  get '/successful_matches', to: 'matches#successful_matches'
  get '/get_potential_matchees', to: 'matches#get_potential_matchees'
  get '/find_all_match_entries', to: 'users#find_match_entries'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
