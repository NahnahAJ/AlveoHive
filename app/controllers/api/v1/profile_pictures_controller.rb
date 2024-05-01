module Api
  module V1
    class ProfilePicturesController < ApplicationController

      skip_before_action :verify_authenticity_token

      def index
        @profile_pictures = UserDetail.find(params[:user_detail_id])
        @profile_picture = @profile_pictures.profile_picture

        if @profile_picture.attached?
          render json: { image: url_for(@profile_picture) }
        else
          render json: { error: 'Profile picture not found' }, status: :not_found
        end
      end

      def show
        @profile_picture = UserDetail.find(params[:user_detail_id]).profile_picture
        if @profile_picture.attached?
          render json: { image: url_for(@profile_picture) }
        else
          render json: { error: 'Profile picture not found' }, status: :not_found
        end 
      end

      def create
        @user_detail = UserDetail.find(params[:user_detail_id])
        @profile_picture = @user_detail.profile_picture || @user_detail.build_profile_picture
      
        if @profile_picture.attach(params[:image])
          render json: { image: url_for(@profile_picture) }
        else
          render json: { error: 'Failed to attach image to profile picture' }, status: :unprocessable_entity
        end
      rescue ActiveRecord::RecordNotFound
        logger.error @profile_picture.errors.inspect
        render json: { error: 'User detail not found' }, status: :not_found
      rescue => e
        render json: { error: e.message }, status: :unprocessable_entity
      end
      

      def update
        @profile_picture = UserDetail.find(params[:user_detail_id]).profile_picture
        @profile_picture.purge
        @profile_picture.attach(params[:image])
        render json: { image: url_for(@profile_picture) }
      end

      def destroy
        @profile_picture = UserDetail.find(params[:user_detail_id]).profile_picture
        @profile_picture.purge
        render json: { status: 'Image deleted' }
      end     
 end
end
end