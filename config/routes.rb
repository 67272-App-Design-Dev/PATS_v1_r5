Rails.application.routes.draw do

  # Semi-static page routes
  get 'home', to: 'home#index', as: :home
  get 'home/about', to: 'home#about', as: :about
  get 'home/contact', to: 'home#contact', as: :contact
  get 'home/privacy', to: 'home#privacy', as: :privacy
  get 'home/search', to: 'home#search', as: :search

  # Authentication routes
  resources :sessions
  resources :users
  get 'users/new', to: 'users#new', as: :signup
  get 'user/edit', to: 'users#edit', as: :edit_current_user
  get 'login', to: 'sessions#new', as: :login
  get 'logout', to: 'sessions#destroy', as: :logout

  # Resource routes (maps HTTP verbs to controller actions automatically):
  resources :owners
  resources :animals
  resources :pets

  resources :visits
  resources :dosages
  resources :treatments
  resources :medicines
  resources :procedures

  # Routes for mecidine and procedure costs
  get 'medicine_costs/new', to: 'medicine_costs#new', as: :new_medicine_cost
  get 'procedure_costs/new', to: 'procedure_costs#new', as: :new_procedure_cost
  post 'medicine_costs', to: 'medicine_costs#create', as: :medicine_costs
  post 'procedure_costs', to: 'procedure_costs#create', as: :procedure_costs

  # Routes for searching
  # get 'medicines/search', to: 'medicines#search', as: :medicine_search
  # get 'owners/search', to: 'owners#search', as: :owner_search
  # get 'pets/search', to: 'pets#search', as: :pet_search

  # You can have the root of your site routed with 'root'
  root 'home#index'

end
