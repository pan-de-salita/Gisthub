Rails.application.routes.draw do
  root 'headquarters#overview'
  get '/solutions', to: 'headquarters#solutions'
end
