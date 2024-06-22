class AdminUser < ApplicationRecord
       validate :validate_max_admin_users, on: :create
       devise :database_authenticatable, :registerable,
       :recoverable, :rememberable, :validatable

       private

       def validate_max_admin_users
         if AdminUser.count >= 1
           errors.add(:base, "Maximum number of admin users reached. Only 1 admin is allowed.")
         end
       end

end
