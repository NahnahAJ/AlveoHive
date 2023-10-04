Rails.application.routes.draw do

namespace :api do 
  namespace :v1 do 
    resources :user_details, only: [:index, :create, :show, :destroy]

    resources :amenities, only: [:index, :create, :show, :destroy]

    #resources :articles, only: [:index, :create, :show, :destroy]
    resources :articles do
      collection do
        get 'search', to: 'articles#search_by_title'
      end
    end

    resources :users do
      resources :articles, only: [:index], controller: 'articles', action: 'user_articles'
      resources :enquiries, only: [:index], controller: 'enquiries', action: 'user_enquiries'
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

    #resources :properties, only: [:index, :create, :show, :destroy]
    resources :properties do
      resources :enquiries, only: [:index], controller: 'enquiries', action: 'property_enquiries'
      member do
        get 'images'
        get 'video'
      end
    end
  end
end

end