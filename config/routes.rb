Rails.application.routes.draw do
 
  get 'categories/new'

  get 'sessions/new'

  get 'users/new'

  root 'articles#index'
  get 'static_pages/home'
  get '/grizzly',    to: 'static_pages#home'
  get  '/help',      to: 'static_pages#help'
  get '/contact',    to: 'static_pages#contact'
  get '/wisdom',     to: 'static_pages#wisdom'
  get  '/signup',    to: 'users#new'
  post '/signup',    to: 'users#create'
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  
  resources :users
  resources :articles
  resources :categories
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
