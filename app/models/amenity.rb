class Amenity < ApplicationRecord
belongs_to :property

serialize :others, Array

# This line ensures that there is only one amenity per property
validates :property_id, uniqueness: true

end