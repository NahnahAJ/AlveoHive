class User < ApplicationRecord
    has_secure_password
  
    has_many :properties
    has_many :articles
    has_many :enquiries
  
    validates :username, presence: true, uniqueness: true
    validates :email, presence: true, uniqueness: true
    validates :password, presence: true, length: { minimum: 6 }
  
    enum role: [:normal, :admin]
  
    def generate_token
      JWT.encode({ user_id: id }, JWT_SECRET_KEY)
    end
  end
  