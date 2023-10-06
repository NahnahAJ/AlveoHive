class User < ApplicationRecord
  include Devise::JWT::RevocationStrategies::JTIMatcher
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

         has_one :user_detail 
         has_many :properties
         has_many :articles
         has_many :enquiries
       
         validates :username, presence: true, uniqueness: true
         validates :email, presence: true, uniqueness: true
          validates :password, presence: true, length: { minimum: 6 }
end
