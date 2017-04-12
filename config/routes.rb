Rails.application.routes.draw do
  root 'pages#home'
  get 'pages/home', to: 'pages#home'
  get "duties/:id/get_json", :controller=>"duties", :action=>"get_json"
  resources :duties
  get "/signup", to:"drivers#new"
  resources :drivers, except: [:new]
  get '/login', to:"sessions#new"
  post '/login', to:"sessions#create"
  delete '/logout', to: "sessions#destroy"
  get '/drivers/:id/dashboard', to: "drivers#dash", as: :dashboard
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
