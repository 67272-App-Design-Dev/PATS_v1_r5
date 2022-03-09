Rails.application.routes.draw do
  # Rails knows that somehow we will add links to certain pages to navigate between them.
  #  As an end user, you would not like to type URLs all the time to go to a certain page and view that certain page to another one. 
  # We are very familiar with links: they make our life easy.

  get '/owners', to: 'owners#index', as: :owners 

  # This will create a owners_path helper method: is going to take me to the combination of "Get and /owners""
  # The prefix is whatever comes before path. The path part is added automatically
  # So owners_path gets me this route -->   get '/owners', to: 'owners#index' and would take me to the index page. 
  # Without the helpers, if we would like to specify a link to a certain page, we would need to specify the http verb, and the URI. 
  # While with the helpers, we could just say just use owners_path and it would take us to the owners index page. 
  # Basically each of the templates in the views has its own helper. 

  # GET routes
  get '/owners/new', to: 'owners#new', as: :new_owner
  get '/owners/:id/edit', to: 'owners#edit', as: :edit_owner
  get '/owners/:id', to: 'owners#show', as: :owner

  # Other routes
  post '/owners', to: 'owners#create'
  patch '/owners/:id', to: 'owners#update'
  delete '/owners/:id', to: 'owners#destroy'

  # Helpers are only for Get HTTP requests. No helpers for the operations that happen only at the database level. 
  # For Create, Update and Destroy, there is no page to see, again because these just happen behind the scenes, 
  # there is no helper provided for this operation. We cannot link to a page for create/Update/Destroy

  # All the above could be simply replaced by
  # resources :owners

  # Resource routes (maps HTTP verbs to controller actions automatically):
  resources :pets
  resources :animals
  resources :visits
  resources :dosages
  resources :treatments
  resources :medicines
  resources :procedures

  # Routes for mecidine and procedure costs
# In some cases, we would like to create our own routes. 
# For example, let's say we say that there should not be an index page for medicine cost,
#  If we were to open medicine_cost in PATS, we did not design a whole index page for it, but associated it instead with a particular medicine. 
# A particular cost could be added this way, and the costs  of a certain medicine including the one we added can be displayed only on this one page
#  in addition to the details of the medicine.
#  There is no need to create a full index page of all teh costs page with medicine cost.
# So, in this particular case, we would not want to use resources, but rather create the paths manually.
#  Add routes for the functions offered only: so, we need a form to add a new medicine_cost.
# We specify the: 
# - get: my http verb
# - my URL: medicine_cost/new
# Map to this controller#action combination, and then this 'as', this is where I am creating for myself a named helper. 
# So if I say new_medicine_cost_path, it would take me to that empty form to fill it and create a new medecine 
  get 'medicine_costs/new', to: 'medicine_costs#new', as: :new_medicine_cost
  get 'procedure_costs/new', to: 'procedure_costs#new', as: :new_procedure_cost

  post 'medicine_costs', to: 'medicine_costs#create', as: :medicine_costs
  post 'procedure_costs', to: 'procedure_costs#create', as: :procedure_costs
  




  # Semi-static page routes
  get 'home', to: 'home#index', as: :home
  get 'home/about', to: 'home#about', as: :about
  get 'home/contact', to: 'home#contact', as: :contact
  get 'home/privacy', to: 'home#privacy', as: :privacy
  # You can have the root of your site routed with 'root'
  root 'home#index'



  get 'home/search', to: 'home#search', as: :search
  # Routes for searching
  # get 'medicines/search', to: 'medicines#search', as: :medicine_search
  # get 'owners/search', to: 'owners#search', as: :owner_search
  # get 'pets/search', to: 'pets#search', as: :pet_search



  # Authentication routes
  resources :users


  resources :sessions

  
  get 'users/new', to: 'users#new', as: :signup
  get 'users/:id/edit', to: 'users#edit', as: :edit_current_user


  get 'login', to: 'sessions#new', as: :login
  get 'logout', to: 'sessions#destroy', as: :logout


end
