module Api
    module V1

      class Api::V1::CategoriesController < ApplicationController
        #before_action :authenticate_user!
        #load_and_authorize_resource

        # GET /api/v1/categories
        def index
          if params[:parent_category].present?
            @categories = Category.where(parent_category: params[:parent_category])
          else
            @categories = Category.all
          end
          render json: @categories
        end

        # GET /api/v1/categories/1
        def show
          @category = Category.find_by(id: params[:id])

          if @category.present?
            render json: @category
          else
            render json: { error: "Category with ID #{params[:id]} not found" }, status: :not_found
          end
        end

        # POST /api/v1/categories
        def create
          @category = Category.new(category_params)

          if @category.save
            render json: @category, status: :created
          else
            render json: @category.errors, status: :unprocessable_entity
          end
        end

        
        # PATCH/PUT /api/v1/categories/1
        def update
          @category = Category.find(params[:id])

          if @category.update(category_params)
            render json: @category
          else
            render json: { errors: @category.errors.full_messages }, status: :unprocessable_entity
          end
        end

        # DELETE /api/v1/categories/1
        def destroy
          @category = Category.find(params[:id])
          @category.destroy
          head :no_content
        end

        private

        def category_params
          params.require(:category).permit(:name, :parent_category)
        end
      end

    end
  end
  