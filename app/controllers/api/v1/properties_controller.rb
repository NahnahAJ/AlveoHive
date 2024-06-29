module Api
  module V1

    require 'fastimage'
    require 'streamio-ffmpeg'

    class Api::V1::PropertiesController < ApplicationController
    # TODO: remove the below in production
    skip_before_action :verify_authenticity_token
      #before_action :authenticate_user!, except: [:index, :show]
      # load_and_authorize_resource

      before_action :set_property, only: [:delete_image, :clear_images]
      before_action :increment_hit_count, only: [:show]

      #################### Property begins #########################

      # GET /api/v1/properties
      def index
        # @properties = Property.all
        @properties = Property.order(created_at: :desc).page(params[:page]).per(params[:per_page] || 30)
        serialized_properties = @properties.map { |property| serialize_property_with_media(property) }
        # render json: serialized_properties
        render json: {
          properties: serialized_properties,
          total_pages: @properties.total_pages,
          total_items: @properties.total_count
        }
        
      end

      # GET /api/v1/users/:id/properties (for listing all the properties of a particular user)
      def user_properties
        @user_properties = Property.where(user_id: params[:user_id]).order(created_at: :desc)
      
        if @user_properties.present?
          serialized_properties = @user_properties.map { |property| serialize_property_with_media(property) }
          render json: serialized_properties
        else
          render json: { error: "No property found for user with ID #{params[:user_id]}" }, status: :not_found
        end
      end

      # GET /api/v1/properties/:id/export_pdf
      def export_pdf
        @property = Property.find(params[:id])

        if @property.is_property_live?
          @amenities = @property.amenities
          @image_urls = []

          # Generate full URLs for the images
          @property.images.limit(5).each do |image|
            image_path = rails_blob_url(image, only_path: true)
            @image_urls << image_path
          end

          html_content = ActionController::Base.new.render_to_string(
            template: "export_pdf",
            locals: { property: @property, amenities: @amenities, image_urls: @image_urls, property_url: api_v1_property_url(@property) },
            layout: "pdf_layout"
          )


          
          pdf = WickedPdf.new.pdf_from_string(html_content)

          send_data(pdf, filename: @property.name + '.pdf', type: 'application/pdf', disposition: 'inline')
        else
          render json: { message: 'Cannot export pdf as this property has not yet been approved for listing.' }, status: :unprocessable_entity
        end
      end

      # GET /api/v1/properties/:id/export_hyperlink
      def export_hyperlink
        @property = Property.find(params[:id])

        if @property.is_property_live?
          render json: { hyperlink: api_v1_property_url(@property) }
        else
          render json: { message: 'Cannot return hyperlink as this property has not yet been approved for listing.' }, status: :unprocessable_entity
        end
      end

      # GET /api/v1/properties/:id
      def show
        properties = Property.where(id: params[:id], is_property_live: true)

        if properties.present?
          serialized_properties = properties.map { |property| serialize_property_with_media(property) }
          render json: serialized_properties
        else
          render json: { error: "Property with ID #{params[:id]} not found" }, status: :not_found
        end
      end

      # POST /api/v1/properties
      def create
        @property = Property.new(property_params)
        handle_file_uploads

        user_id = property_params[:user_id]
        user = User.find_by(id: user_id)
        user_details = UserDetail.find_by(user_id: user_id)

        subscription_status = user_details&.subscription
        last_subscription_date = user_details&.last_subscription_date
        # live_properties_count = Property.where(user_id: user_id, is_property_live: true).count
        properties_count = Property.where(user_id: user_id).count

        if (subscription_status == 'subscribed' && last_subscription_date.present? && last_subscription_date >= 1.year.ago) ||
           (subscription_status != 'subscribed' && properties_count < 3)
          if @property.save
            render json: serialize_property_with_media(@property), status: :created
            PropertyApprovalMailer.property_submitted_for_review(@property).deliver_now
          else
            render json: { errors: @property.errors.full_messages }, status: :unprocessable_entity
          end
        else
          render json: { message: "Please upgrade/renew your subscription for unlimited property listing." }, status: :unauthorized
        end
      end


      # PATCH/PUT /api/v1/properties/:id
      def update
        @property = Property.find(params[:id])

        handle_file_uploads

        if @property.update(property_params)
          serialized_property = @property.map { |property| serialize_property_with_media(property) }
          render json: serialize_property
        else
          render json: { errors: @property.errors.full_messages }, status: :unprocessable_entity
        end
      end

      # DELETE /api/v1/properties/:id
      def destroy
        @property = Property.find(params[:id])
        @property.destroy
        head :no_content
      end

      # GET /api/v1/properties/:id/get_images
      def get_images
        @property = Property.find(params[:id])
        images_data = @property.images.map { |image| { id: image.id, url: rails_blob_url(image, only_path: true) } }
        render json: { images: images_data }
      end

      # DELETE /api/v1/properties/:id/images/:image_id
      def delete_image
        image = @property.images.find(params[:image_id])
        image.purge
        render json: { message: 'Image deleted successfully' }
      end

      # DELETE /api/v1/properties/:id/clear_images
      def clear_images
        @property = Property.find(params[:id])
        @property.images.purge
        render json: { message: 'All images cleared successfully' }
      end

      # GET /api/v1/properties/:id/get_video
      def get_video
        @property = Property.find(params[:id])
        render json: { video: video_url(@property.video) }
      end

      # DELETE /api/v1/properties/:id/delete_video
      def delete_video
        @property = Property.find(params[:id])

        if @property.video.attached?
          @property.video.purge
          render json: { message: 'Video deleted successfully' }
        else
          render json: { message: 'No video attached to delete' }, status: :unprocessable_entity
        end
      end

        # GET /api/v1/properties/search
        def search
          properties_table = Property.arel_table
          order_clause = properties_table[:created_at].desc
          # Join properties with user_details to access subscription status
          @properties = Property.joins(user: :user_detail)
                                .where(is_property_live: true)
                                .filter_by_params(search_params)
                                # .order(
                                #   Arel.sql("CASE WHEN user_details.subscription = 'subscribed' AND user_details.last_subscription_date >= '#{1.year.ago.to_s(:db)}' THEN 0 ELSE 1 END, properties.created_at DESC")
                                # )
                                .order(order_clause)
                                .page(params[:page])
                                .per(params[:per_page] || 30)

          if @properties.empty?
            # if no exact match is found, provide similar items as suggestions
            similar_items = find_similar_items(search_params)
            render json: {
              similar_properties: similar_items
            }, status: :not_found
          else
            serialized_properties = @properties.map { |property| serialize_property_with_media(property) }
            render json: {
              properties: serialized_properties,
              total_pages: @properties.total_pages,
              total_items: @properties.total_count
            }
          end
        end

      # PATCH/PUT /api/v1/properties/:id/set_live
      def set_live
        @property = Property.find(params[:id])

        if @property.is_property_live?
          render json: { message: 'Property has already been approved for listing!' }
        else
          if @property.update(is_property_live: true, date_listed: Time.zone.now)
            # Send approval email to both the user and alveohive support
            PropertyApprovalMailer.property_approved(@property).deliver_now
            render json: { message: 'Property is now live!' }
          else
            render json: { error: 'Failed to update property status' }, status: :unprocessable_entity
          end
        end
      end

      # returns a list of all properties that have been approved for listing
      # GET /api/v1/properties/live_properties
      def live_properties
        live_properties = Property.joins(user: :user_detail)
                                  .where(is_property_live: true)
                                  .order(Arel.sql("CASE WHEN user_details.subscription = 'subscribed' AND user_details.last_subscription_date >= '#{1.year.ago.to_s(:db)}' THEN 0 ELSE 1 END, properties.created_at DESC"))
                                  .page(params[:page])
                                  .per(params[:per_page] || 30)

        serialized_properties = live_properties.map { |property| serialize_property_with_media(property) }

        render json: {
          properties: serialized_properties,
          total_pages: live_properties.total_pages,
          total_items: live_properties.total_count
        }
      end

      # GET /api/v1/properties/pending_properties
      def pending_properties
        pending_properties = Property.where(is_property_live: false)
        serialized_properties = pending_properties.map { |property| serialize_property_with_media(property) }

        render json: serialized_properties, include: {
          amenities: {
            only: [:fully_fitted_kitchen, :furnishing, :standby_generator, :internet_connectivity, :ac_rooms, :refridgerator, :cctv_camera, :washroom, :security_service, :tv, :gym, :others, :walled_gated, :parking_space, :living_room, :dining_room, :waste_disposal]
          },
          property_detail: {
            only: [:has_room_serviced, :number_of_storeys, :pet_friendly_compound, :compound_finishing, :finishing, :bathroom_type_and_location, :year_built, :street, :payment_plan, :state_of_land, :number_of_tenants, :type_of_meter, :source_of_water, :property_needs_renovation, :smoking_allowed, :tiled_areas, :ceiling_type]
          },
          public_facility: {
            only: [:schools, :hospitals, :pharmacies, :others]
          },
          recreational_facility: {
            only: [:restaurants, :pubs, :gyms, :others]
          }
        }
      end

      # POST /api/v1/properties/:id/rate
      def rate
        @property = Property.find(params[:id])
        new_rating = params[:rating].to_f

        if not params[:rating]
          return render json: { error: "Invalid rating key or value. The key should be 'rating' and the value can be anywhere between 0.0 to 5.0" }, status: :unprocessable_entity
        end

        unless (0.0..5.0).cover?(new_rating)
          return render json: { error: 'Invalid rating. Rating should be between 0.0 and 5.0.' }, status: :unprocessable_entity
        end

        current_ratings = @property.ratings || 0.0
        current_number_of_ratings = @property.number_of_ratings || 0
      
        if current_ratings.zero? && @property.number_of_ratings == 0
          updated_ratings = new_rating
        else
          updated_ratings = ((current_ratings * current_number_of_ratings + new_rating) / (current_number_of_ratings + 1)).round(2)
        end
      
        @property.update(
          ratings: updated_ratings,
          number_of_ratings: current_number_of_ratings + 1
        )
      
        render json: { message: 'Property rated successfully', average_rating: updated_ratings }
      end

      #################### Property begins #########################
      

      #################### Amenity begins #########################
      
      # Get all amenities related to a property
      # GET /api/v1/properties/:id/amenities
      def amenities
        @property = Property.find_by(id: params[:id])

        if @property.present?
          render json: { amenities: @property.amenities.map { |amenity| amenity.attributes.merge(others: amenity.others) } }
          #render json: { amenities: @property.amenities }
        else
          render json: { error: 'Property not found' }, status: :not_found
        end
      end

      # POST /api/v1/properties/:id/add_amenity
      def add_amenity
        @property = Property.find_by(id: params[:id])

        if @property.present?
          @amenity = @property.amenities.create(amenity_params)
          render json: @amenity, status: :created
        else
          render json: { error: 'Property not found' }, status: :not_found
        end
      end

      # PATCH /api/v1/properties/:id/update_amenity/:id
      def update_amenity
        @property = Property.find_by(id: params[:id])
        @amenity = Amenity.find_by(id: params[:amenity_id])

        if @property.present? && @amenity.present?
          @amenity.update(amenity_params)
          render json: @amenity
        else
          render json: { error: 'Property or Amenity not found' }, status: :not_found
        end
      end

      # DELETE /api/v1/properties/:id/delete_amenity/:id
      def delete_amenity
        @property = Property.find_by(id: params[:id])
        @amenity = Amenity.find_by(id: params[:amenity_id])

        if @property.present? && @amenity.present?
          @amenity.destroy
          head :no_content
        else
          render json: { error: 'Property or Amenity not found' }, status: :not_found
        end
      end
      
      #################### Amenity ends #########################


      #################### Enquiry begins #########################

      # get all enquiries related to a property
      # GET /api/v1/properties/:id/enquiries
      def property_enquiries
        @property = Property.find_by(id: params[:id])

        if @property.present?
          @property_enquiries = @property.enquiries
          render json: { property_enquiries: @property_enquiries }
        else
          render json: { error: 'Property not found' }, status: :not_found
        end
      end

      #################### Enquiry ends #########################


      private

      def property_params
        params.require(:property).permit(
          :name, :property_type, :is_property_live, :commercial_property_type, :location, :property_status, :property_overview, 
          :number_of_bedrooms, :number_of_bathrooms, :ratings, 
          :furnishing, :size, :price, :date_listed, :is_property_live, 
          :number_of_ratings, :latitude, :longitude, :currency, :user_id,
          :video, images: [],
          amenities_attributes: [
            :property_id, :fully_fitted_kitchen, :furnishing, :standby_generator,
            :internet_connectivity, :ac_rooms, :refridgerator, :cctv_camera, :washroom, :security_service,
            :tv, :gym, :walled_gated, :parking_space, :living_room, :dining_room, :waste_disposal,
            :others
          ],
          property_detail_attributes: [
            :has_room_serviced, :number_of_storeys, :pet_friendly_compound,
            :compound_finishing, :finishing, :bathroom_type_and_location, :year_built, :street,
            :payment_plan, :state_of_land, :number_of_tenants, :type_of_meter, :source_of_water,
            :property_needs_renovation, :smoking_allowed, :tiled_areas, :ceiling_type
          ],
          public_facility_attributes: [
            :schools, :hospitals, :pharmacies,
            :others
          ],
          recreational_facility_attributes: [
            :restaurants, :pubs, :gyms,
            :others
          ]
        )
      end        

      def amenity_params
        params.require(:amenity).permit(
          :fully_fitted_kitchen, :standby_generator, :internet_connectivity, :ac_rooms, :furnishing,
          :refridgerator, :cctv_camera, :washroom, :security_service, :tv, :gym, :parking_space, 
          :living_room, :dining_room, :walled_gated, :others
        )
      end

      def increment_hit_count
        @property = Property.find(params[:id])
        if @property.present?
          @property.hits_count += 1
          @property.save(validate: false)
        else
          render json: { error: "Property with ID #{params[:id]} not found" }, status: :not_found
        end
      end

      def handle_file_uploads
        if @property.new_record?
          current_image_count = 0
          has_video = false
        else
          current_image_count = @property.images.count

          has_video = @property.video.attached?
        end
        
        # upload limits
        max_image_limit = 5
        max_video_limit = 1
        max_image_size_mb = 10
        max_video_size_mb = 80

        if params[:images] || params.dig(:property, :images)
          uploaded_images = params[:images] || params.dig(:property, :images)
          remaining_image_slots = max_image_limit - current_image_count

          if uploaded_images.size > remaining_image_slots
            #return render json: { error: "Image upload limit exceeded. You can upload up to #{remaining_image_slots} more images." }, status: :unprocessable_entity
          end

          attachments = []

          uploaded_images.each do |image|
            begin
              decoded_image = Base64.decode64(image)
      
              format = FastImage.type(decoded_image)
      
              image = MiniMagick::Image.read(decoded_image)
              image.resize '300x200'
              image.format('jpeg')
      
              blob = ActiveStorage::Blob.create_after_upload!(
                io: StringIO.new(image.to_blob),
                filename: "image_#{Time.now.to_i}.jpeg",
                content_type: 'image/jpeg'
              )
      
              attachments << { io: blob, filename: blob.filename.to_s }
            rescue => e
              #return render json: { error: "Failed to process image upload. #{e.message}" }, status: :unprocessable_entity
            end
          end
          # attach the image/s after validation checks
          @property.images.attach(attachments)
        end

        if params[:video]
          video_data = Base64.decode64(params[:video])
        
          video_size_mb = video_data.bytesize / 1024.0 / 1024.0
        
          if video_size_mb > max_video_size_mb
            # return render json: { error: "Video size exceeds the maximum limit of #{max_video_size_mb} MB." }, status: :unprocessable_entity
          end
        
          compatible_formats = ['mp4', 'webm']
          video_format = FFMPEG::Movie.new(StringIO.new(video_data)).format_name.downcase
        
          unless compatible_formats.include?(video_format)
            # return render json: { error: "Invalid video format. Only #{compatible_formats.join(', ')} formats are allowed." }, status: :unprocessable_entity
          end
        
          movie = FFMPEG::Movie.new(StringIO.new(video_data))
          if movie.duration > 30
            # Trim the video to the first 30 seconds using ffmpeg
            trimmed_video_data = trim_video(video_data, 30)
        
            # Attach the trimmed video after validation checks
            @property.video.attach(io: StringIO.new(trimmed_video_data), filename: "video_#{Time.now.to_i}.#{video_format}")
          else
            # Attach the original video without trimming
            @property.video.attach(io: StringIO.new(video_data), filename: "video_#{Time.now.to_i}.#{video_format}")
          end
        end          
      end  

      def trim_video(video_data, duration_limit)
        temp_folder = Rails.root.join('tmp') # Adjust 'tmp' to your desired temp folder name
      
        # Ensure that the temp folder exists; create it if not
        FileUtils.mkdir_p(temp_folder) unless File.directory?(temp_folder)
      
        Tempfile.open(['trimmed_video', '.mp4'], temp_folder) do |tempfile|
          tempfile.binmode
          tempfile.write(video_data)
          tempfile.rewind
      
          # Use ffmpeg to trim the video to the specified duration
          system("ffmpeg -i #{tempfile.path} -t #{duration_limit} -c copy #{tempfile.path}_trimmed.mp4")
      
          # Check if the trimming was successful
          if $?.success?
            trimmed_file_path = "#{tempfile.path}_trimmed.mp4"
      
            # Check if the trimmed file exists before attempting to read it
            if File.exist?(trimmed_file_path)
              # Read the trimmed video back into memory
              trimmed_video_data = File.read(trimmed_file_path)
      
              # Ensure the tempfile is closed
              tempfile.close
      
              return trimmed_video_data
            else
              tempfile.close
              raise StandardError.new("Trimmed video file not found.")
            end
          else
            tempfile.close
            raise StandardError.new("Video trimming failed.")
          end
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

      # to search for a property using price and/or size range, use for example-> search?price[]=50000&price[]=100000
      def search_params
        params.permit(
          :property_type, :is_property_live, :commercial_property_type, :location, :property_status, :number_of_bedrooms, :number_of_bathrooms,
          :ratings, :currency, :page, :per_page, price: [], size: [], amenities: [
          :fully_fitted_kitchen, :standby_generator, :internet_connectivity, :ac_rooms, :furnishing,
          :refridgerator, :cctv_camera, :washroom, :security_service, :tv, :gym, :parking_space, 
          :living_room, :dining_room, :walled_gated, :others
          ]
        )
      end

      def find_similar_items(search_params)
        # Find and return similar items based on search criteria
        properties = Property.where(is_property_live: true)
      
        properties = properties.where("property_status ILIKE ?", "%#{search_params[:property_status]}%") if search_params[:property_status].present?
        properties = properties.where("property_type ILIKE ?", "%#{search_params[:property_type]}%") if search_params[:property_type].present?

        if search_params[:min_price].present? && search_params[:max_price].present?
          price_range = search_params[:min_price].to_i..search_params[:max_price].to_i

          # If currency is specified in the search parameters, use it; otherwise, default to 'GHS'
          specified_currency = search_params[:currency].present? ? search_params[:currency].upcase : 'GHS'
       
          # Get unique currencies in the database
          unique_currencies = properties.distinct.pluck(:currency)
      
          # Fetch conversion rates from the database
          conversion_rates = Currency.all.pluck(:name, :conversion_rates).to_h
      
          # Default conversion rate (same currency)
          default_conversion_rate = 1.0
      
          or_conditions = unique_currencies.map do |currency|
            if currency.upcase == specified_currency
              # If the property's currency matches the specified currency, no conversion needed
              properties.where(
                "currency = ? AND price BETWEEN ? AND ?",
                currency,
                price_range.min,
                price_range.max
              )
            else
              # If the property's currency is different, perform the conversion
              conversion_rate = conversion_rates.dig(currency.upcase, specified_currency)
              properties.where(
                "currency = ? AND (price * ?) BETWEEN ? AND ?",
                currency,
                conversion_rate,
                price_range.min,
                price_range.max
              )
            end
          end
      
          # Include properties with the default currency (GHS)
          or_conditions << properties.where(currency: 'GHS', price: price_range)
      
          properties = or_conditions.inject(:or)
        end
      
        properties = properties.where("size BETWEEN ? AND ?", search_params[:min_size], search_params[:max_size]) if search_params[:min_size].present? && search_params[:max_size].present?

        properties_with_score = properties.map do |property|
          score = 0
      
          score += 1 if property.number_of_bedrooms == search_params[:number_of_bedrooms]
          score += 1 if property.location == search_params[:location]
              
          { property: property, score: score }
        end
      
        sorted_properties = properties_with_score.sort_by { |item| item[:score] }.reverse
      
        # Grab the top 16 similar properties
        result = sorted_properties.take(16).map { |item| item[:property] }
        serialized_properties = result.map { |property| serialize_property_with_media(property) }
        serialized_properties.as_json(
          include: {
            amenities: {
              only: [:fully_fitted_kitchen, :furnishing, :standby_generator, :internet_connectivity, :ac_rooms, :refridgerator, :cctv_camera, :washroom, :security_service, :tv, :gym, :others, :walled_gated, :parking_space, :living_room, :dining_room, :waste_disposal]
            },
            property_detail: {
              only: [:has_room_serviced, :number_of_storeys, :pet_friendly_compound, :compound_finishing, :finishing, :bathroom_type_and_location, :year_built, :street, :payment_plan, :state_of_land, :number_of_tenants, :type_of_meter, :source_of_water, :property_needs_renovation, :smoking_allowed, :tiled_areas, :ceiling_type]
            },
            public_facility: {
              only: [:schools, :hospitals, :pharmacies, :others]
            },
            recreational_facility: {
              only: [:restaurants, :pubs, :gyms, :others]
            }
          }
        )
      end

      def serialize_properties(properties)
        properties.map { |property| serialize_property(property) }
      end

      def serialize_property_with_media(property)
        serialized_property = serialize_property(property)
      
        if property.images.attached?
          image_urls = property.images.map { |image| rails_blob_url(image) }
          serialized_property[:images] = image_urls
        end
      
        if property.video.attached?
          serialized_property[:video] = video_url(property.video)
        end

        # Set cache control headers for 2 minutes
        expires_in 2.minutes, public: true

        serialized_property
      end               

      def serialize_property(property)
        property.as_json(
          include: {
            amenities: {
              only: [:fully_fitted_kitchen, :furnishing, :standby_generator, :internet_connectivity, :ac_rooms, :refridgerator, :cctv_camera, :washroom, :security_service, :tv, :gym, :others, :walled_gated, :parking_space, :living_room, :dining_room, :waste_disposal]
            },
            property_detail: {
              only: [:has_room_serviced, :number_of_storeys, :pet_friendly_compound, :compound_finishing, :finishing, :bathroom_type_and_location, :year_built, :street, :payment_plan, :state_of_land, :number_of_tenants, :type_of_meter, :source_of_water, :property_needs_renovation, :smoking_allowed, :tiled_areas, :ceiling_type]
            },
            public_facility: {
              only: [:schools, :hospitals, :pharmacies, :others]
            },
            recreational_facility: {
              only: [:restaurants, :pubs, :gyms, :others]
            }
          }
        )
      end

      def set_property
        @property = Property.find(params[:id])
      end

    end
  end
end
