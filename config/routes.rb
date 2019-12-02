Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  ## companies

  get '/companies', to: "companies#index", as: "companies"
  post '/companies', to: "companies#create"
  get '/companies/new', to: "companies#new", as: "new_company"
  get '/companies/:id', to: "companies#show", as: "company"

  ## calendars

  post '/calendars/add_partner', to: "calendars#add_partner"
  post '/calendars', to: "calendars#create"
  get '/calendar/new', to: "calendars#new", as: "new_calendar"
  get '/calendars/:id', to: "calendars#show", as: "calendar"

  ## partnerships

  post '/parterships', to: "parterships#create"

  ## events

  post '/events', to: "events#create"


end
