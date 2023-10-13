module Api
  module V1
    class ProfilePicturesController < ApplicationController

      def index
        @profile_pictures = UserDetail.find(params[:user_detail_id])
        @profile_picture = @profile_pictures.profile_picture

        if @profile_picture.attached?
          render json: { image: url_for(@profile_picture) }
        else
          render json: { error: 'Profile picture not found' }, status: :not_found
        end
      end
        
 end
end
end