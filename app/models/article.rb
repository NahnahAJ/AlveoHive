class Article < ApplicationRecord
  belongs_to :user
  belongs_to :category

  validates :title, presence: true
  validates :content, presence: true, length: { maximum: 10000 } # Set the maximum allowable words to 10,000

end
