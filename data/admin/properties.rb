ActiveAdmin.register Property do

  action_item :approve, only: :show, if: -> { !resource.is_property_live } do
    link_to 'Approve Property', approve_admin_property_path(resource), method: :put
  end

  member_action :approve, method: :put do
    resource.update(is_property_live: true)

    # Send mail
    PropertyApprovalMailer.property_approved(@property).deliver_now

    redirect_to admin_property_path(resource), notice: 'Property approved successfully!'
  end

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :user_id, :name, :location, :property_status, :property_overview, :hits_count, :number_of_bedrooms, :number_of_bathrooms, :ratings, :furnishing, :size, :price, :date_listed, :is_property_live, :number_of_ratings, :latitude, :longitude, :currency, :property_type, :commercial_property_type
  filter :images
  filter :video
  #
  # or
  #
  # permit_params do
  #   permitted = [:user_id, :name, :location, :property_status, :property_overview, :number_of_bedrooms, :number_of_bathrooms, :ratings, :furnishing, :size, :price, :date_listed, :is_property_live, :number_of_ratings, :latitude, :longitude, :currency, :hits_count, :property_type, :commercial_property_type]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  
end
