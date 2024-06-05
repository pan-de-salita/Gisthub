Rails.application.routes.draw do
  root 'headquarters#overview'
  get 'headquarters/repositories'
end
