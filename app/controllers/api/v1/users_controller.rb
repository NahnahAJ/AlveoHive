module Api
  module V1
    class UsersController < ApplicationController

      skip_before_action :verify_authenticity_token

      def index
        @users = User.all
        render json: @users
      end

      def show
        @user = User.find(params[:id])
        render json: @user
      end

      def create
        @user = User.create(user_params)
        render json: @user
      end

      def update
        @user = User.find(params[:id])
        @user.update(user_update_params)
        render json: @user
      end      

      def destroy
        @user = User.find(params[:id])
        @user.destroy
        render json: @user
      end

      private

      def user_params
        params.require(:user).permit(:firstname, :lastname, :email, :role, :password)
      end

      def user_update_params
        params.require(:user).permit(:firstname, :lastname, :role)
      end
    end
  end
end