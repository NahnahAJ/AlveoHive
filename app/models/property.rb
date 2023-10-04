class Property < ApplicationRecord
  belongs_to :user
  belongs_to :category
  has_many :amenities


  scope :filter_by_params, ->(params) {
    result = all

    result = result.where(category_id: params[:category_id]) if params[:category_id].present?
    result = result.where(location: params[:location]) if params[:location].present?
    result = result.where(property_status: params[:property_status]) if params[:property_status].present?
    result = result.where(number_of_bedrooms: params[:number_of_bedrooms]) if params[:number_of_bedrooms].present?
    result = result.where(number_of_bathrooms: params[:number_of_bathrooms]) if params[:number_of_bathrooms].present?
    result = result.where(ratings: params[:ratings]) if params[:ratings].present?
    result = result.where(furnishing: params[:furnishing]) if params[:furnishing].present?
    result = result.where(size: params[:size]) if params[:size].present?
    result = result.where(price: params[:price]) if params[:price].present?

    if params[:amenities].present?
      amenities_conditions = {}
      params[:amenities].each do |amenity, value|
        amenities_conditions[amenity] = value if Property.column_names.include?(amenity) && Property.type_for_attribute(amenity).type == :boolean
      end
      result = result.where(amenities_conditions)
    end

    if params[:others].present?
      result = result.joins(:amenities).where("amenities.others ILIKE ?", "%#{params[:others]}%")
    end

    result
  }

end
