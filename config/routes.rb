Rails.application.routes.draw do
  resources :matches
  resources :users
  
  post '/matches/check', to: 'matches#check_for_existing_entry'
  get '/user_matches', to: 'matches#user_matches'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
