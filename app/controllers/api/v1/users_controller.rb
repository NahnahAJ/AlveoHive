module Api
    module V1
      class UsersController < ApplicationController

        skip_before_action :authorize_request, only: [:register, :login, :logout, :logout_all]
        before_action :authorize_user, only: [:update, :destroy]

        # POST /api/v1/users/register
        def register
          user = User.new(user_params)
          if user.save
            render json: { user: user, token: user.generate_token }, status: :created
          else
            render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
          end
        end

        # POST /api/v1/users/login
        def login
          user = User.find_by(username: params[:username])
          if user && user.authenticate(params[:password])
            render json: { user: user, token: user.generate_token }
          else
            render json: { error: 'Invalid username or password' }, status: :unauthorized
          end
        end
  
        # POST /api/v1/users/logout
        def logout
          invalidate_token
          head :no_content
        end
  
        # POST /api/v1/users/logout_all
        def logout_all
          invalidate_all_tokens
          head :no_content
        end
  
        # GET /api/v1/users
        def index
          users = User.all
          render json: users
        end
  
        # GET /api/v1/users/:id
        def show
          user = User.find(params[:id])
          render json: user
        end
  
        # PUT /api/v1/users/:id
        def update
          user = User.find(params[:id])
          if user.update(user_params)
            render json: user
          else
            render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
          end
        end
  
        # DELETE /api/v1/users/:id
        def destroy
          user = User.find(params[:id])
          user.destroy
          head :no_content
        end
  
        private
  
        def user_params
          params.permit(:username, :password, :email, :role)
        end

        def authorize_user
            render_unauthorized unless current_user.id == params[:id].to_i
          end
  
        def authorize_admin
          render_unauthorized unless current_user.admin?
        end
  
        def render_unauthorized
          render json: { error: 'Unauthorized' }, status: :unauthorized
        end

      def invalidate_token
        payload = {
          exp: Time.now.to_i - 1, # here, I set expiration time in the past
          sub: @current_user.id
        }
        JWTSessions::Session.new(payload: payload).flush_by_token(session[:jwt])
      end

      def invalidate_all_tokens
        JWTSessions::Session.new(payload: payload).flush_by_uid(current_user.id)
      end

      end
    end
  end
  