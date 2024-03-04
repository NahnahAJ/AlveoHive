# app/controllers/application_controller.rb

class ApplicationController < ActionController::Base
  # skip_before_action :verify_authenticity_token
rescue_from CanCan::AccessDenied do |exception|
  render json: { message: exception.message }, status: :forbidden
end

# def cors_set_access_control_headers
#   headers['Access-Control-Allow-Origin'] = '*'
#   headers['Access-Control-Allow-Methods'] = 'POST, PUT, DELETE, GET, PATCH, OPTIONS'
#   headers['Access-Control-Request-Method'] = '*'
#   headers['Access-Control-Allow-Headers'] = 'Origin, X-Requested-With, Content-Type, Accept, Authorization'
# end
end
