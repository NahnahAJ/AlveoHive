module Api
  module V1
    class SocialsController < ApplicationController
      def index
        # code to retrieve all socials
        @socials = Social.all
        render json: @socials
      end

      def show
        # code to retrieve a single social by id
        @social = Social.find(params[:id])
        render json: @social
      end

      def create
        # code to create a new social
        @social = Social.create(social_params)
        render json: @social
      end

      def update
        # code to update an existing social by id
        @social = Social.find(params[:id])
        @social.update(social_params)
        render json: @social
      end

      def destroy
        # code to delete an existing social by id
        @social = Social.find(params[:id])
        @social.destroy
        render json: @social
      end

      private

      def social_params
        params.require(:social).permit(
          :instagram,
          :facebook,
          :twitter,
          :linkedin,
          :whatsapp,
          :user_id
        )
      end
    end
  end
end