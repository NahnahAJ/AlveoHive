module Api
    module V1
      class UserDetailsController < ApplicationController
        before_action :authenticate_user
  
        # GET /api/v1/userdetails/by_user/:user_id
        def show
          user_details = UserDetails.find_by(user_id: params[:user_id])
          render json: user_details
        end
  
        # PUT /api/v1/userdetails/:id
        def update
          user_details = UserDetails.find(params[:id])
          if user_details.update(user_details_params)
            render json: user_details
          else
            render json: { errors: user_details.errors.full_messages }, status: :unprocessable_entity
          end
        end
  
        private
  
        def user_details_params
          params.permit(:name, :bio, :role, :address, :country, :profile_picture, :company_name, :mobile_phone, :office_phone)
        end
      end
    end
  end
  