module Api
  module V1
    module Admin
      class PropertiesController < ApplicationController
        before_action :authorize_admin

        # GET /api/v1/admin/properties
        def index
          properties = Property.all
          render json: properties
        end

        # GET /api/v1/admin/properties/:id
        def show
          property = Property.find(params[:id])
          render json: property
        end

        # PUT /api/v1/admin/properties/:id
        def update
          property = Property.find(params[:id])
          if property.update(property_params)
            render json: property
          else
            render json: { errors: property.errors.full_messages }, status: :unprocessable_entity
          end
        end

        # DELETE /api/v1/admin/properties/:id
        def destroy
          property = Property.find(params[:id])
          property.destroy
          head :no_content
        end

        private

        def property_params
          params.require(:property).permit(:name, :location, :property_status, :images, :video, :property_overview,
                                          :number_of_bedrooms, :number_of_bathrooms, :ratings, :amenities, :furnishing,
                                          :size, :price, :date_listed, :user_id, :category_id)
        end
      end
    end
  end
end
