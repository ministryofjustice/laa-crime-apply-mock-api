Rails.application.routes.draw do

  # Defines the root path route ("/")
  # root "articles#index"
  get 'api/message', to: 'application#message'
  get 'api/v1/maat/applications', to: 'application#maatapplication'

  mount Datastore::Root => '/'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  root to: proc { [200, {}, ['']] }

  get :ping, to: 'status#ping'
  get :health, to: 'status#health'

  # catch-all route
  match '*path', to: 'errors#not_found', via: :all, constraints:
    lambda { |_request| !Rails.application.config.consider_all_requests_local }
end
