class Amenity < ApplicationRecord
belongs_to :property

# This line ensures that there is only one amenity per property
validates :property_id, uniqueness: true

end