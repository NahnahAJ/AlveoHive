module Api
    module V1
      class CurrenciesController < ApplicationController
        before_action :set_currency, only: [:update, :destroy]
  
        # GET /api/v1/currencies
        def index
          currencies = Currency.all
          render json: currencies, status: :ok
        end
  
        # POST /api/v1/currencies
        def create
          currency = Currency.new(currency_params)
  
          if currency.save
            render json: currency, status: :created
          else
            render json: { errors: currency.errors.full_messages }, status: :unprocessable_entity
          end
        end
  
        # PATCH/PUT /api/v1/currencies/:id
        def update
          current_rates = @currency.conversion_rates || {}
          new_rates = currency_params[:conversion_rates]
      
          current_rates.merge!(new_rates)
      
          if @currency.update(conversion_rates: current_rates)
            render json: @currency, status: :ok
          else
            render json: @currency.errors, status: :unprocessable_entity
          end
        end
  
        # DELETE /api/v1/currencies/:id
        def destroy
          @currency.destroy
          head :no_content
        end
  
        private
  
        def set_currency
          @currency = Currency.find(params[:id])
        end
  
        def currency_params
          params.require(:currency).permit(:name, rates: {}, conversion_rates: {})
        end
      end
    end
  end
  