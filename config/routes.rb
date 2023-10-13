Rails.application.routes.draw do
  get '/current_user', to: 'current_user#index'
    devise_for :users, path: '', path_names: {
      sign_in: 'login',
      sign_out: 'logout',
      registration: 'signup'
    },
    controllers: {
      sessions: 'users/sessions',
      registrations: 'users/registrations'
    }

namespace :api do 
  namespace :v1 do 
    resources :users, only: [:index, :create, :show, :destroy]
    resources :user_details, only: [:index, :create, :show, :destroy, :update] do
    resources :profile_pictures, only: [:index, :show]
    end
    resources :amenities, only: [:index, :create, :show, :destroy]
  end
end

end