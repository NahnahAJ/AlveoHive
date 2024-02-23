# app/controllers/application_controller.rb

class ApplicationController < ActionController::Base
rescue_from CanCan::AccessDenied do |exception|
  render json: { message: exception.message }, status: :forbidden
end
end
