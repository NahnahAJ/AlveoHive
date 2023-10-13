class UserDetail < ApplicationRecord
  belongs_to :user
  
  validates :name, presence: true
  has_one_attached :profile_picture
  
end
