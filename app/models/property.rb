class Property < ApplicationRecord
  belongs_to :user
  belongs_to :category
  has_many :amenities
end
