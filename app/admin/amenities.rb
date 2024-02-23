ActiveAdmin.register Amenity do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :property_id, :fully_fitted_kitchen, :furnishing, :standby_generator, :internet_connectivity, :ac_rooms, :refridgerator, :cctv_camera, :washroom, :security_service, :tv, :gym, :others, :walled_gated, :parking_space, :living_room, :dining_room, :waste_disposal
  #
  # or
  #
  # permit_params do
  #   permitted = [:property_id, :fully_fitted_kitchen, :furnishing, :standby_generator, :internet_connectivity, :ac_rooms, :refridgerator, :cctv_camera, :washroom, :security_service, :tv, :gym, :others, :walled_gated, :parking_space, :living_room, :dining_room, :waste_disposal]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  
end
