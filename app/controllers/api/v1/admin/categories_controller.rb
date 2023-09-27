module Api
  module V1
    module Admin
      class CategoriesController < ApplicationController
        before_action :authorize_admin

        # GET /api/v1/admin/categories
        def index
          categories = Category.all
          render json: categories
        end

        # GET /api/v1/admin/categories/:id
        def show
          category = Category.find(params[:id])
          render json: category
        end

        # PUT /api/v1/admin/categories/:id
        def update
          category = Category.find(params[:id])
          if category.update(category_params)
            render json: category
          else
            render json: { errors: category.errors.full_messages }, status: :unprocessable_entity
          end
        end

        # DELETE /api/v1/admin/categories/:id
        def destroy
          category = Category.find(params[:id])
          category.destroy
          head :no_content
        end

        private

        def category_params
          params.require(:category).permit(:name)
        end
      end
    end
  end
end
