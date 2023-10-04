Rails.application.routes.draw do

namespace :api do 
  namespace :v1 do 
    resources :users, only: [:index, :create, :show, :destroy]
    resources :user_details, only: [:index, :create, :show, :destroy]
    resources :amenities, only: [:index, :create, :show, :destroy]
  end
end
end