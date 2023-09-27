module Api
    module V1
      module Admin
        class UsersController < ApplicationController
          before_action :authorize_admin
  
          # GET /api/v1/admin/users
          def index
            users = User.all
            render json: users
          end
  
          # GET /api/v1/admin/users/:id
          def show
            user = User.find(params[:id])
            render json: user
          end
  
          # PUT /api/v1/admin/users/:id
          def update
            user = User.find(params[:id])
            if user.update(user_params)
              render json: user
            else
              render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
            end
          end
  
          # DELETE /api/v1/admin/users/:id
          def destroy
            user = User.find(params[:id])
            user.destroy
            head :no_content
          end
  
          private
  
          def user_params
            params.permit(:username, :password, :email, :role)
          end
        end
      end
    end
  end
  