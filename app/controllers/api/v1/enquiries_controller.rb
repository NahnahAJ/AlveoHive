module Api
    module V1

      class Api::V1::EnquiriesController < ApplicationController
        #before_action :authenticate_user!
        load_and_authorize_resource

        # GET /api/v1/enquiries
        def index
          @enquiries = Enquiry.all
          render json: @enquiries
        end

        # GET /api/v1/enquiries/1
        def show
          @enquiry = Enquiry.find_by(id: params[:id])

          if @enquiry.present?
            render json: @enquiry
          else
            render json: { error: "Enquiry with ID #{params[:id]} not found" }, status: :not_found
          end
        end

        # POST /api/v1/enquiries
        def create
          @enquiry = Enquiry.new(enquiry_params)

          if @enquiry.save
            render json: @enquiry, status: :created
          else
            render json: { errors: @enquiry.errors.full_messages }, status: :unprocessable_entity
          end
        end

        # PATCH/PUT /api/v1/enquiries/1
        def update
          @enquiry = Enquiry.find(params[:id])

          if @enquiry.update(enquiry_params)
            render json: @enquiry
          else
            render json: { errors: @enquiry.errors.full_messages }, status: :unprocessable_entity
          end
        end

        # DELETE /api/v1/enquiries/1
        def destroy
          @enquiry = Enquiry.find(params[:id])
          @enquiry.destroy
          head :no_content
        end

        # GET /api/v1/users/1/enquiries
        def user_enquiries
          @user_enquiries = Enquiry.where(user_id: params[:user_id])
          render json: @user_enquiries
        end

        # GET /api/v1/properties/1/enquiries
        def property_enquiries
          @property_enquiries = Enquiry.where(property_id: params[:property_id])
          render json: @property_enquiries
        end

        private

        def set_enquiry
          @enquiry = Enquiry.find(params[:id])
        end

        def enquiry_params
          params.require(:enquiry).permit(:property_id, :user_id, :phone, :message)
        end
      end

    end
  end  