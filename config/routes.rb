Rails.application.routes.draw do
  resources :users do
    resources :languages
    resources :solutions do
      # get 'in_language', action: :index
    end
  end

  get '/overview/', to: 'headquarters#overview', as: 'overview'
  get 'solutions', to: 'solutions#index', as: 'solutions'
  get 'solutions/in_language/:programming_language', to: 'solutions#index', as: 'solutions_in_language'
  get 'solutions/new', to: 'solutions#new', as: 'new_solution'
  post 'solutions', to: 'solutions#create'
end
