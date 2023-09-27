module Api
    module V1
      class EnquiriesController < ApplicationController
        before_action :authorize_user, only: [:create]
        before_action :authorize_user_or_admin, only: [:index, :show, :update, :destroy]
  
        # POST /api/v1/enquiries
        def create
          enquiry = current_user.enquiries.build(enquiry_params)
          if enquiry.save
            render json: enquiry, status: :created
          else
            render json: { errors: enquiry.errors.full_messages }, status: :unprocessable_entity
          end
        end
  
        # GET /api/v1/enquiries
        def index
          enquiries = Enquiry.all
          render json: enquiries
        end
  
        # GET /api/v1/enquiries/:id
        def show
          enquiry = Enquiry.find(params[:id])
          render json: enquiry
        end
  
        # PUT /api/v1/enquiries/:id
        def update
          enquiry = Enquiry.find(params[:id])
          if enquiry.update(enquiry_params)
            render json: enquiry
          else
            render json: { errors: enquiry.errors.full_messages }, status: :unprocessable_entity
          end
        end
  
        # DELETE /api/v1/enquiries/:id
        def destroy
          enquiry = Enquiry.find(params[:id])
          enquiry.destroy
          head :no_content
        end
  
        private
  
        def enquiry_params
          params.permit(:property_id, :phone, :message)
        end
  
        def authorize_user_or_admin
          render_unauthorized unless current_user.admin? || current_user.id == enquiry.user_id
        end
      end
    end
  end  