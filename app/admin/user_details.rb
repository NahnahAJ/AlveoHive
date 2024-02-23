ActiveAdmin.register UserDetail do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :user_id, :name, :bio, :address, :company_name, :mobile_phone, :office_phone, :user_type, :subscription, :last_subscription_date
  filter :profile_picture
  
  #
  # or
  #
  # permit_params do
  #   permitted = [:user_id, :name, :bio, :address, :country, :company_name, :mobile_phone, :office_phone, :user_type, :subscription, :last_subscription_date]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  
end
