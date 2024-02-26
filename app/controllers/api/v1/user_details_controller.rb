module Api
  module V1
    class UserDetailsController < ApplicationController
      load_and_authorize_resource      
      
      def index
        @user_details = UserDetail.all
        render json: @user_details
      end

      def show
        @user_detail = UserDetail.find(params[:id])
        render json: @user_detail
      end

      def create
        @user_detail = UserDetail.create(user_detail_params)
        render json: @user_detail
      end

      def update
        @user_detail = UserDetail.find(params[:id])
        @user_detail.update(user_detail_params)
        render json: @user_detail
      end

      def destroy
        @user_detail = UserDetail.find(params[:id])
        @user_detail.destroy
        render json: @user_detail
      end

      private

      def user_detail_params
        params.require(:user_detail).permit(
          :name,
          :bio,
          :role,
          :address,
          :country,
          :profile_picture,
          :company_name,
          :mobile_phone,
          :office_phone,
          :user_type,
          :user_id
        )
      end

    end
  end
end
