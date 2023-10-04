module Api
    module V1

      class Api::V1::PropertiesController < ApplicationController
        #before_action :authenticate_user!, except: [:index, :show]
        #load_and_authorize_resource

        # GET /api/v1/properties
        def index
          @properties = Property.all
          render json: @properties
        end

        # GET /api/v1/properties/1
        def show
          @property = Property.find_by(id: params[:id])

          if @property.present?
            render json: @property
          else
            render json: { error: "Property with ID #{params[:id]} not found" }, status: :not_found
          end
        end

        # POST /api/v1/properties
        def create
          @property = Property.new(property_params)

          handle_file_uploads

          if @property.save
            render json: @property, status: :created
          else
            render json: { errors: @property.errors.full_messages }, status: :unprocessable_entity
          end
        end

        # PATCH/PUT /api/v1/properties/1
        def update
          @property = Property.find(params[:id])

          handle_file_uploads

          if @property.update(property_params)
            render json: @property
          else
            render json: { errors: @property.errors.full_messages }, status: :unprocessable_entity
          end
        end

        # DELETE /api/v1/properties/1
        def destroy
          @property = Property.find(params[:id])
          @property.destroy
          head :no_content
        end

        # GET /api/v1/properties/1/images
        def images
          @property = Property.find(params[:id])
          render json: { images: image_urls(@property.images) }
        end

        # GET /api/v1/properties/1/video
        def video
          @property = Property.find(params[:id])
          render json: { video: video_url(@property.video) }
        end

        # GET /api/v1/properties/search
        def search
          # Filter properties based on dynamic search parameters
          @properties = Property.filter_by_params(search_params)

          render json: @properties
        end

        private

        def property_params
          params.require(:property).permit(
            :user_id, :category_id, :name, :location, :property_status, :property_overview,
            :number_of_bedrooms, :number_of_bathrooms, :ratings, :furnishing, :size, :price, :date_listed
          )
        end

        def handle_file_uploads
          if params[:images]
            params[:images].each do |image|
              @property.images.attach(io: StringIO.new(Base64.decode64(image)), filename: "image_#{Time.now.to_i}.png")
            end
          end

          if params[:video]
            video_data = Base64.decode64(params[:video])
            @property.video.attach(io: StringIO.new(video_data), filename: "video_#{Time.now.to_i}.mp4")
          end
        end

        def image_urls(images)
          if images.present?
            images.map { |image| rails_blob_path(image, only_path: true) }
          else
            []
          end
        end

        def video_url(video)
          if video.present?
            rails_blob_path(video, only_path: true)
          else
            'No video available'
          end
        end

        def search_params
          params.permit(
            :category_id, :location, :property_status, :number_of_bedrooms, :number_of_bathrooms,
            :ratings, :furnishing, :size, :price, :amenities, :others
          )
        end

      end
    end
  end
  