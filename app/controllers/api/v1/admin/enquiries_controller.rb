module Api
  module V1
    module Admin
      class EnquiriesController < ApplicationController
        before_action :authorize_admin

        # GET /api/v1/admin/enquiries
        def index
          enquiries = Enquiry.all
          render json: enquiries
        end

        # GET /api/v1/admin/enquiries/:id
        def show
          enquiry = Enquiry.find(params[:id])
          render json: enquiry
        end

        # PUT /api/v1/admin/enquiries/:id
        def update
          enquiry = Enquiry.find(params[:id])
          if enquiry.update(enquiry_params)
            render json: enquiry
          else
            render json: { errors: enquiry.errors.full_messages }, status: :unprocessable_entity
          end
        end

        # DELETE /api/v1/admin/enquiries/:id
        def destroy
          enquiry = Enquiry.find(params[:id])
          enquiry.destroy
          head :no_content
        end

        private

        def enquiry_params
          params.require(:enquiry).permit(:property_id, :user_id, :phone, :message)
        end
      end
    end
  end
end
