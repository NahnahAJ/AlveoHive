module Api
  module V1
    module Admin
      class ArticlesController < ApplicationController
        before_action :authorize_admin

        # GET /api/v1/admin/articles
        def index
          articles = Article.all
          render json: articles
        end

        # GET /api/v1/admin/articles/:id
        def show
          article = Article.find(params[:id])
          render json: article
        end

        # PUT /api/v1/admin/articles/:id
        def update
          article = Article.find(params[:id])
          if article.update(article_params)
            render json: article
          else
            render json: { errors: article.errors.full_messages }, status: :unprocessable_entity
          end
        end

        # DELETE /api/v1/admin/articles/:id
        def destroy
          article = Article.find(params[:id])
          article.destroy
          head :no_content
        end

        private

        def article_params
          params.require(:article).permit(:title, :content, :category_id, :author_id)
        end
      end
    end
  end
end
