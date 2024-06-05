Rails.application.routes.draw do
  root 'headquarters#overview'
  get '/repositories', to: 'headquarters#repositories'
end
