class AdminUsers::RegistrationsController < Devise::RegistrationsController
    before_action :redirect_to_root, only: [:new, :create]
  
    private
  
    def redirect_to_root
      redirect_to root_path, alert: "Sign up is not allowed."
    end
end