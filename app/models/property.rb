class Property < ApplicationRecord
  belongs_to :user
  belongs_to :category
  has_many :amenities

  has_many_attached :images
  has_one_attached :video

  validate :validate_image_limit
  validate :validate_image_size
  validate :validate_image_types

  validate :validate_video_size


  scope :filter_by_params, ->(params) {
    result = all

    result = result.where(category_id: params[:category_id]) if params[:category_id].present?
    result = result.where(location: params[:location]) if params[:location].present?
    result = result.where(property_status: params[:property_status]) if params[:property_status].present?
    result = result.where(number_of_bedrooms: params[:number_of_bedrooms]) if params[:number_of_bedrooms].present?
    result = result.where(number_of_bathrooms: params[:number_of_bathrooms]) if params[:number_of_bathrooms].present?
    result = result.where(ratings: params[:ratings]) if params[:ratings].present?
    result = result.where(furnishing: params[:furnishing]) if params[:furnishing].present?

    if params[:price].present?
      price_range = params[:price].map(&:to_i)
      result = result.where(price: price_range[0]..price_range[1])
    end

    if params[:size].present?
      size_range = params[:size].map(&:to_i)
      result = result.where(size: size_range[0]..size_range[1])
    end

    if params[:amenities].present?
      amenities_conditions = {}
      params[:amenities].each do |amenity, value|
        if Property.column_names.include?(amenity) && Property.type_for_attribute(amenity).type == :boolean
          result = result.joins(:amenities).where("amenities.#{amenity} = ?", value)
        else
          amenities_conditions[amenity] = value
        end
      end
      result = result.where(amenities_conditions)
    end

    if params[:others].present?
      result = result.joins(:amenities).where("amenities.others ILIKE ?", "%#{params[:others]}%")
    end

    result
  }


  private

  def validate_image_limit
    if images.attached? && images.count > 5
      errors.add(:images, 'cannot be more than 5')
    end
  end

  def validate_image_size
    images.each do |image|
      if image.byte_size > 5.megabytes
        errors.add(:images, 'should be less than 5MB')
      end
    end
  end

  def validate_image_types
    allowed_types = %w[image/jpeg image/jpg image/png]

    images.each do |image|
      unless allowed_types.include?(image.content_type)
        errors.add(:images, 'should be JPEG, JPG, or PNG format')
      end
    end
  end

  def validate_video_size
    if video.attached? && video.byte_size > 60.megabytes
      errors.add(:video, 'size should be 60MB or less')
    end
  end

end
