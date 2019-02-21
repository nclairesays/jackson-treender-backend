Rails.application.routes.draw do
  resources :matches
  resources :users


  
  post '/matches/check', to: 'matches#check_existing_entries'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
