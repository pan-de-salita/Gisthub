Rails.application.routes.draw do
  resources :users do
    resources :languages do
      resources :solutions
    end
  end

  root 'headquarters#overview'
  get '/solutions', to: 'headquarters#solutions'
end
