Rails.application.routes.draw do
  # resources :media
  # resources :categories
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  get '/search/:query', to: 'media#query'
end
