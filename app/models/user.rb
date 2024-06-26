class User < ApplicationRecord
  include Devise::JWT::RevocationStrategies::JTIMatcher
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :validatable, :recoverable, :rememberable,
  :jwt_authenticatable, jwt_revocation_strategy: self 

         has_one :user_detail
         has_one :social 
         has_many :properties
         has_many :articles
         has_many :enquiries

         validates :email, presence: true, uniqueness: true, on: :create
         validates :password, presence: true, length: { minimum: 6 }, on: :create

    def admin?
      role == 'admin'
    end


    def subscribed?
      user_details = UserDetail.find_by(user_id: id)
      
      # Check if user_details exist and subscription is 'subscribed'
      return false unless user_details && user_details.subscription == 'subscribed'
  
      # Check if last_subscription_date is within the recent 1 year
      last_subscription_date = user_details.last_subscription_date
      return false unless last_subscription_date && last_subscription_date >= 1.year.ago
  
      true
    end
end
