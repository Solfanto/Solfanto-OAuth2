Rails.application.routes.draw do
  devise_for :users
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  use_doorkeeper
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  root to: 'static#index'
  get '/oauth/token/info/me', to: 'token_info#me'
  
  get '/.well-known/acme-challenge/:id', to: 'static#letsencrypt'
  
  get '/test/mockup_callback', to: 'static#test_mockup_callback' if Rails.env.test?
end
