Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  get '/current_user', to: 'current_user#index'
    devise_for :users, path: '', path_names: {
      sign_in: 'login',
      sign_out: 'logout',
      registration: 'signup',
      passwords: 'users/password'
    },
    controllers: {
      sessions: 'users/sessions',
      registrations: 'users/registrations',
      passwords: 'users/password'
    }

    namespace :admin do
      resources :properties do
        member do
          put :approve
        end
      end
    end

    # successful payment handling
    post '/payments/success', to: 'payments#success'
    # mobile money payment endpoint
    post '/payments/mobile_money', to: 'payments#mobile_money'
    # send otp endpoint
    post '/payments/submit_otp', to: 'payments#submit_otp'
    # webhook url for listening for events from paystack
    post '/webhooks/paystack', to: 'webhooks#paystack'
    # endpoint for updating the user payment reference
    post '/payments/update_user_reference/:id', to: 'payments#update_user_reference'

    # url for checking subscription status
    get '/subscription/subscribed', to: 'subscription#subscribed'

namespace :api do 
  namespace :v1 do 

    resources :users, only: [:index, :create, :show, :destroy, :update] do
      resources :articles, only: [:index], controller: 'articles', action: 'user_articles'
      resources :enquiries, only: [:index], controller: 'enquiries', action: 'user_enquiries'
      resources :properties, only: [:index], controller: 'properties', action: 'user_properties'
    end

    resources :user_details, only: [:index, :create, :show, :destroy, :update] do
    resources :profile_pictures, only: [:index, :show, :create, :destroy, :update]
  end
  
    resources :socials, only: [:index, :create, :show, :update, :destroy]
    resources :amenities, only: [:index, :create, :show, :destroy]

    resources :articles do
      collection do
        get 'search', to: 'articles#search_by_title'
      end
    end


    #resources :categories, only: [:index, :create, :show, :destroy]
    resources :categories do
      collection do
        get 'by_parent/:parent_category', to: 'categories#index', as: :by_parent
      end
      resources :articles, only: [:index], controller: 'articles', action: 'category_articles'
    end

    #resources :enquiries, only: [:index, :create, :show, :destroy]
    resources :enquiries do
      collection do
        get 'search', to: 'enquiries#search_by_message'
      end
    end

    resources :currencies, only: [:index, :create, :update, :destroy]

    #resources :properties, only: [:index, :create, :show, :destroy]
    resources :properties do
      collection do
        get 'search'
        get 'live_properties'
        get 'pending_properties'
      end

    resources :schools do
      collection do
        get 'get_schools'
      end
    end

    resources :enquiries, only: [:index], controller: 'enquiries', action: 'property_enquiries'
    get 'export_pdf', on: :member
    post 'rate', on: :member
    delete 'delete_video', on: :member
    delete 'images/:image_id', to: 'properties#delete_image', on: :member, as: 'delete_image'
    delete 'clear_images', to: 'properties#clear_images', on: :member, as: 'clear_images'
  
      member do
        get 'get_images'
        get 'get_video'
        get 'export_hyperlink'
        get 'amenities', to: 'properties#amenities'
        post 'add_amenity', to: 'properties#add_amenity'
        patch 'update_amenity/:amenity_id', to: 'properties#update_amenity'
        delete 'delete_amenity/:amenity_id', to: 'properties#delete_amenity'
        get 'enquiries', to: 'properties#property_enquiries'
        patch 'set_live', to: 'properties#set_live'
      end
    end
  end
end
end

