class Property < ApplicationRecord
  belongs_to :user

  has_one :property_detail
  has_one :public_facility
  has_one :recreational_facility
  has_one :amenities, class_name: 'Amenity'
  accepts_nested_attributes_for :amenities
  accepts_nested_attributes_for :property_detail
  accepts_nested_attributes_for :public_facility
  accepts_nested_attributes_for :recreational_facility

  has_many_attached :images
  has_one_attached :video

  validates :currency, presence: true, inclusion: { in: %w(USD GHS EUR GBP), message: "%{value} is not a valid currency. Options are USD, GHS, EUR and GBP" }

  # validate :validate_image_limit
  # validate :validate_image_size
  # validate :validate_image_types

  # validate :validate_video_size


  scope :filter_by_params, ->(params) {
    result = all

    result = result.where(category_id: params[:category_id]) if params[:category_id].present?
    result = result.where("LOWER(location) LIKE ?", "%#{params[:location].downcase}%") if params[:location].present?
    result = result.where("LOWER(property_status) = ?", params[:property_status].downcase) if params[:property_status].present?  
    result = result.where(number_of_bedrooms: params[:number_of_bedrooms]) if params[:number_of_bedrooms].present?
    result = result.where(number_of_bathrooms: params[:number_of_bathrooms]) if params[:number_of_bathrooms].present?
    result = result.where(ratings: params[:ratings]) if params[:ratings].present?
    result = result.where("LOWER(furnishing) LIKE ?", "%#{params[:furnishing].downcase}%") if params[:furnishing].present?
    result = result.where("LOWER(property_type) = ?", params[:property_type].downcase) if params[:property_type].present?  


    if params[:price].present? && params[:currency].present?
      price_range = params[:price].map(&:to_i)
      specified_currency = params[:currency].upcase

      # Get unique currencies for the properties that match other search criteria
      unique_currencies = result.distinct.pluck(:currency)

      if unique_currencies.include?(specified_currency)
        # If the specified currency is present in the retrieved currencies, no need for conversion
        result = result.where(price: price_range[0]..price_range[1])
      else
        # Fetch conversion rates from the database
        if unique_currencies.present?
          currency_record = Currency.find_by(name: specified_currency)
          conversion_rates = currency_record&.conversion_rates || {}
        
          # Build a dynamic SQL expression for price conversion
          conversion_expression = unique_currencies.map do |currency|
            conversion_rate = conversion_rates[currency] || 1.0
            "(CASE WHEN currency = '#{specified_currency}' THEN price ELSE price * #{conversion_rate} END)"
          end.join(' + ')
        
          # Use the dynamic expression in the query
          result = result.where("#{conversion_expression} BETWEEN ? AND ?", price_range[0], price_range[1])
        else
          # If unique_currencies is empty, set a default condition
          result = result.where("price BETWEEN ? AND ?", price_range[0], price_range[1])
        end
      end
    # If currency is not specified, perform currency and price comparison using 'GHS' as the default currency
    elsif params[:price].present?
      puts "Currency is not specified, performing currency and price comparison"

      price_range = params[:price].map(&:to_i)
      
      # Filter properties that are live
      result = result.where(is_property_live: true)

      # Get unique currencies in the database
      unique_currencies = result.distinct.pluck(:currency)

      # Fetch conversion rates from the database
      conversion_rates = Currency.all.pluck(:name, :conversion_rates).to_h

      # Default conversion rate (same currency)
      default_conversion_rate = 1.0

      # Build a dynamic SQL query
      or_conditions = unique_currencies.map do |currency|
        # Set the conversion rate based on the property's currency
        conversion_rate = currency.upcase == 'GHS' ? default_conversion_rate : conversion_rates.dig(currency.upcase, 'GHS')

        # Create OR conditions
        result.where(
          "currency = ? AND price * ? BETWEEN ? AND ?",
          currency,
          conversion_rate,
          price_range[0],
          price_range[1]
        )
      end

      # Include properties with the default currency (GHS)
      or_conditions << result.where(currency: 'GHS', price: price_range[0]..price_range[1])

      # Combine all OR conditions
      result = or_conditions.inject(:or)
    end

    if params[:size].present?
      size_range = params[:size].map(&:to_i)
      result = result.where(size: size_range[0]..size_range[1])
    end

    if params[:amenities].present?
      amenities_conditions = {}
      params[:amenities].each do |amenity, value|
        if Amenity.column_names.include?(amenity) && Amenity.type_for_attribute(amenity).type == :boolean
          result = result.joins(:amenities).where("amenities.#{amenity} = ?", value)
        else
          amenities_conditions["amenities.#{amenity}"] = value
        end
      end
      result = result.where(amenities_conditions)
    end
    
    result
  }


  private

  # def validate_image_limit
  #   if images.attached? && images.count > 5
  #     errors.add(:images, "cannot be more than 5. You tried uploading #{images.count} images")
  #   end
  # end

  # def validate_image_size
  #   images.each do |image|
  #     if image.byte_size > 5.megabytes
  #       errors.add(:images, 'should be less than 5MB')
  #     end
  #   end
  # end

  # def validate_image_types
  #   allowed_types = %w[image/jpeg image/jpg image/png]

  #   images.each do |image|
  #     unless allowed_types.include?(image.content_type)
  #       errors.add(:images, 'should be JPEG, JPG, or PNG format')
  #     end
  #   end
  # end

  # def validate_video_size
  #   if video.attached? && video.byte_size > 60.megabytes
  #     errors.add(:video, 'size should be 60MB or less')
  #   end
  # end

end
