module Api
    module V1
      class PropertiesController < ApplicationController
        skip_before_action :authorize_user, only: [:index, :show]
        before_action :authorize_user_or_admin, only: [:create, :update, :destroy]
  
        # GET /api/v1/properties
        def index
          properties = Property.all
          render json: properties
        end
  
        # GET /api/v1/properties/:id
        def show
          property = Property.find(params[:id])
          render json: property
        end
  
        # POST /api/v1/properties
        def create
          property = current_user.properties.build(property_params)
          if property.save
            render json: property, status: :created
          else
            render json: { errors: property.errors.full_messages }, status: :unprocessable_entity
          end
        end
  
        # PUT /api/v1/properties/:id
        def update
          property = Property.find(params[:id])
          if property.update(property_params)
            render json: property
          else
            render json: { errors: property.errors.full_messages }, status: :unprocessable_entity
          end
        end
  
        # DELETE /api/v1/properties/:id
        def destroy
          property = Property.find(params[:id])
          property.destroy
          head :no_content
        end
  
        private
  
        def property_params
          params.permit(:name, :location, :property_status, :images, :video, :property_overview, :number_of_bedrooms, :number_of_bathrooms, :ratings, :amenities, :furnishing, :size, :price, :date_listed, :category_id)
        end
  
        def authorize_user_or_admin
          render_unauthorized unless current_user.admin? || current_user.id == property.user_id
        end
      end
    end
  end
  