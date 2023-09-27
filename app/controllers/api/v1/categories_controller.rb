module Api
    module V1
      class CategoriesController < ApplicationController
        skip_before_action :authorize_user, only: [:index, :show]
        before_action :authorize_user_or_admin, only: [:create, :update, :destroy]
  
        # GET /api/v1/categories
        def index
          categories = Category.all
          render json: categories
        end
  
        # GET /api/v1/categories/:id
        def show
          category = Category.find(params[:id])
          render json: category
        end
  
        # POST /api/v1/categories
        def create
          category = Category.new(category_params)
          if category.save
            render json: category, status: :created
          else
            render json: { errors: category.errors.full_messages }, status: :unprocessable_entity
          end
        end
  
        # PUT /api/v1/categories/:id
        def update
          category = Category.find(params[:id])
          if category.update(category_params)
            render json: category
          else
            render json: { errors: category.errors.full_messages }, status: :unprocessable_entity
          end
        end
  
        # DELETE /api/v1/categories/:id
        def destroy
          category = Category.find(params[:id])
          category.destroy
          head :no_content
        end
  
        private
  
        def category_params
          params.permit(:name)
        end
  
        def authorize_user_or_admin
          render_unauthorized unless current_user.admin?
        end
      end
    end
  end
  