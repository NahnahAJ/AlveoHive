class Social < ApplicationRecord
  belongs_to :user
  
  validates :user_id, presence: true
  validates :instagram, :whatsapp, :facebook, :twitter, :linkedin, length: { maximum: 255 }
end
