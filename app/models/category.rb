class Category < ApplicationRecord
    validates :name, presence: true
    validates :parent_category, inclusion: { in: %w[Property Article], message: "must be 'Property' or 'Article'" }  
end
