class Enquiry < ApplicationRecord
  belongs_to :property
  belongs_to :user

  validates :phone, presence: true
  validates :message, presence: true

end
