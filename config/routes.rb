Rails.application.routes.draw do
  resources :users do
    resources :languages
    resources :solutions
  end

  get '/signup', to: 'users#new', as: 'signup'
  delete '/logout', to: 'sessions#destroy', as: 'logout'
  root 'sessions#new'
  post '/sessions', to: 'sessions#create'
  post 'users', to: 'users#create', as: 'create_user'

  get ':alias/overview', to: 'headquarters#overview', as: 'overview'

  get '/:alias/solutions', to: 'solutions#index', as: 'solutions'
  get '/:alias/solutions/:programming_language', to: 'solutions#index', as: 'solutions_in_language'
  get '/:alias/new_solution/', to: 'solutions#new', as: 'new_solution'
  post '/:alias/solutions', to: 'solutions#create', as: 'create_new_solution'
  get '/:alias/solutions/edit/:id', to: 'solutions#edit', as: 'edit_solution'
  patch '/:alias/solutions/:id', to: 'solutions#update', as: 'update_solution'
  get 'solution/:id', to: 'solutions#show', as: 'solution'
  delete 'solution/:id', to: 'solutions#destroy', as: 'destroy_solution'

  get 'languages/new', to: 'langauges#new', as: 'new_languages'
  # get 'solutions/new/:programming_language', to: 'solutions#new', as: 'new_solution_in_language'
  post 'languages', to: 'languages#create'
end
