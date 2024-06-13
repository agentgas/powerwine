class WinesController < ApplicationController
    rescue_from ActiveRecord::RecordInvalid, with: :handle_invalid_record

    def salvage_wines
        new_wines = Openwines::Retrieve.new.retrieve_datas

        render json: new_wines, status: :ok
    end

    def get_wines
        if wine_price_params.has_key?(:price_low) && wine_price_params.has_key?(:price_high) 
            all_wines = Wine.where("price IN (?)", (params[:price_low])..(params[:price_high]))
        else
            all_wines = Wine.all
        end

        render json: all_wines, each_serializer: WineSerializer, status: :ok
    end

    private

    def wine_price_params
        params.permit(:price_low, :price_high)
    end

    def handle_invalid_record(e)
            render json: { errors: e.record.errors.full_messages }, status: :unprocessable_entity
    end
end
