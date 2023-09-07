Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  Rails.application.routes.draw do
    namespace :api, defaults: { format: :json } do
      namespace :v1 do
        resources :maat_applications
      end
    end

  end
  # Defines the root path route ("/")
  # root "articles#index"
  get 'api/message', to: 'application#message'
end
