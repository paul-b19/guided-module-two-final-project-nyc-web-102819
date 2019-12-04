Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root 'companies#index'

  ## companies
  get '/companies', to: "companies#index", as: "companies"
  post '/companies', to: "companies#create"
  get '/companies/new', to: "companies#new", as: "new_company"
  get '/companies/:id', to: "companies#show", as: "company"

  ## calendars
  post '/calendars/add_holidays', to: "calendars#add_holidays"
  post '/calendars/add_partner', to: "calendars#add_partner"
  post '/calendars', to: "calendars#create"
  get '/calendars/new', to: "calendars#new", as: "new_calendar"
  get '/calendars/:id', to: "calendars#show", as: "calendar"

  ## meetings
  # resources :meetings
  get '/meetings', to: "meetings#index", as: "meetings"
  post '/meetings', to: "meetings#create"
  get '/meetings/new', to: "meetings#new", as: "new_meeting"
  get '/meetings/:id/edit', to: "meetings#edit", as: "edit_meeting"
  get '/meetings/:id', to: "meetings#show", as: "meeting"
  patch '/meetings/:id', to: "meetings#update"
  delete 'meetings/:id', to: "meetings#destroy"

  resources :holidays, controller: 'meetings', type: 'Holiday' 
  resources :privates, controller: 'meetings', type: 'Private' 
  resources :shareds, controller: 'meetings', type: 'Shared'


end
