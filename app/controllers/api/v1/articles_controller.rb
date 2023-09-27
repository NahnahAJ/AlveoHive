module Api
    module V1
      class ArticlesController < ApplicationController
        skip_before_action :authorize_user, only: [:index, :show]
        before_action :authorize_user_or_admin, only: [:create, :update, :destroy]
  
        # GET /api/v1/articles
        def index
          articles = Article.all
          render json: articles
        end
  
        # GET /api/v1/articles/:id
        def show
          article = Article.find(params[:id])
          render json: article
        end
  
        # POST /api/v1/articles
        def create
          article = current_user.articles.build(article_params)
          if article.save
            render json: article, status: :created
          else
            render json: { errors: article.errors.full_messages }, status: :unprocessable_entity
          end
        end
  
        # PUT /api/v1/articles/:id
        def update
          article = Article.find(params[:id])
          if article.update(article_params)
            render json: article
          else
            render json: { errors: article.errors.full_messages }, status: :unprocessable_entity
          end
        end
  
        # DELETE /api/v1/articles/:id
        def destroy
          article = Article.find(params[:id])
          article.destroy
          head :no_content
        end
  
        private
  
        def article_params
          params.permit(:title, :content, :category_id)
        end
  
        def authorize_user_or_admin
          render_unauthorized unless current_user.admin? || current_user.id == article.user_id
        end
      end
    end
  end
  