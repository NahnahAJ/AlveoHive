Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      # Users
      post '/users/register', to: 'users#register'
      post '/users/login', to: 'users#login'
      post '/users/logout', to: 'users#logout'
      post '/users/logout_all', to: 'users#logout_all'
      get '/users', to: 'users#index'
      get '/users/:id', to: 'users#show'
      put '/users/:id', to: 'users#update'
      delete '/users/:id', to: 'users#destroy'

      # Properties
      resources :properties, except: [:new, :edit]

      # Articles
      resources :articles, except: [:new, :edit]
      get '/articles/by_author/:author_id', to: 'articles#by_author'

      # UserDetails
      get '/userdetails/by_user/:user_id', to: 'user_details#show'
      put '/userdetails/:id', to: 'user_details#update'

      # Categories
      resources :categories, except: [:new, :edit]

      # Enquiries
      post '/enquiries', to: 'enquiries#create'
      get '/enquiries/by_property/:property_id', to: 'enquiries#by_property'
      get '/enquiries/by_user/:user_id', to: 'enquiries#by_user'

      # Administrative Actions
      namespace :admin do
        resources :users, except: [:new, :edit]
        resources :properties, except: [:new, :edit]
        resources :articles, except: [:new, :edit]
        resources :categories, except: [:new, :edit]
        resources :enquiries, except: [:new, :edit]
      end
    end
  end
end