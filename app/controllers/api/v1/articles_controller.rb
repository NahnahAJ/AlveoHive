module Api
    module V1

      class Api::V1::ArticlesController < ApplicationController
        #before_action :authenticate_user!, except: [:index, :show]
        load_and_authorize_resource

        # GET /api/v1/articles
        def index
          @articles = Article.all
          render json: @articles
        end

        # GET /api/v1/articles/1
        def show
          @article = Article.find_by(id: params[:id])

          if @article.present?
            render json: @article
          else
            render json: { error: "Article with ID #{params[:id]} not found" }, status: :not_found
          end
        end

        # POST /api/v1/articles
        def create
          @article = Article.new(article_params)
          if @article.save
            render json: @article, status: :created
          else
            render json: { errors: @article.errors.full_messages }, status: :unprocessable_entity
          end
        end

        # PATCH/PUT /api/v1/articles/1
        def update
          @article = Article.find(params[:id])

          if @article.update(article_params)
            render json: @article
          else
            render json: { errors: @article.errors.full_messages }, status: :unprocessable_entity
          end
        end

        # DELETE /api/v1/articles/1
        def destroy
          @article = Article.find(params[:id])
          @article.destroy
          head :no_content
        end

        # GET /api/v1/users/1/articles
        def user_articles
          @user_articles = Article.where(user_id: params[:user_id])
          render json: @user_articles
        end

        # GET /api/v1/categories/1/articles
        def category_articles
          @category_articles = Article.where(category_id: params[:category_id])
          render json: @category_articles
        end

        # GET /api/v1/articles/search?title=example
        def search_by_title
          @title_articles = Article.where("title ILIKE ?", "%#{params[:title]}%")
          render json: @title_articles
        end

        private

        def set_article
          @article = Article.find(params[:id])
        end

        def article_params
          params.require(:article).permit(:user_id, :title, :content, :category_id)
        end
      end

    end
  end
  