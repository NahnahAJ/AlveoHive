ActiveAdmin.register User do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :username, :email, :encrypted_password, :role
  filter :encrypted_password
  # permit_params :username, :email, :encrypted_password, :role, :reset_password_token, :reset_password_sent_at, :remember_created_at, :jti
  #
  # or
  #
  # permit_params do
  #   permitted = [:username, :email, :encrypted_password, :role, :reset_password_token, :reset_password_sent_at, :remember_created_at, :jti]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  
end
