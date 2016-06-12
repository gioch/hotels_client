Rails.application.routes.draw do
  root 'hotels#index'
  
  get 'suggestions', to: 'hotels#suggestions'

  resources :hotels
end
