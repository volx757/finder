Finder::Application.routes.draw do

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  root to: 'home#index', as: :home

 # match ':controller(/:action(/:id))(.:format)', :via => [:get, :post]
  post '/users/create', to: 'users#create'

  get '/search', to: 'home#search'
  get '/search_results', to: 'home#search_results'
  get '/work_detail/:id', to: 'home#work_detail'

  get '/browse', to: 'home#browse'
post '/users/update', to: 'users#update'

  post '/works/create', to: 'works#create'

  post "login", :to => "home#login"
  get "logout", :to => "home#logout"
  get "/profile", :to => "users#profile"
  get "settings", :to => "home#settings"

end
