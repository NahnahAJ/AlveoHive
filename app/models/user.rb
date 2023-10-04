class User < ApplicationRecord
    has_one :user_detail 
    has_many :properties
    has_many :articles
    has_many :enquiries
  
    validates :username, presence: true, uniqueness: true
    validates :email, presence: true, uniqueness: true
  end
  