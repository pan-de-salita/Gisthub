Rails.application.routes.draw do
  resources :users do
    resources :languages
    resources :solutions
  end

  get '/overview/', to: 'headquarters#overview', as: 'overview'
  get 'solutions', to: 'solutions#index', as: 'solutions'
  get 'solutions/in_language/:programming_language', to: 'solutions#index', as: 'solutions_in_language'
  get 'solutions/new', to: 'solutions#new', as: 'new_solution'
  # get 'solutions/new/:programming_language', to: 'solutions#new', as: 'new_solution_in_language'
  post 'solutions', to: 'solutions#create'
  get 'solutions/:id/edit', to: 'solutions#edit', as: 'edit_solution'
  patch 'solution/:id', to: 'solutions#update'
  get 'solution/:id', to: 'solutions#show', as: 'solution'
  delete 'solution/:id', to: 'solutions#destroy', as: 'destroy_solution'

  get 'languages/new', to: 'langauges#new', as: 'new_languages'
  # get 'solutions/new/:programming_language', to: 'solutions#new', as: 'new_solution_in_language'
  post 'languages', to: 'languages#create'
end
