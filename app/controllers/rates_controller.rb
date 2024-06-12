class RatesController < ApplicationController
    rescue_from ActiveRecord::RecordInvalid, with: :handle_invalid_record

    def create
        rate = Rate.create!(rate_params)
        
        render json: {
            rate: RateSerializer.new(rate),
        }, status: :created
    end

    def update
        rate = Rate.find(rate_params[:id])
        
        unless rate
            head :not_found
        end

        rate.update(rate: rate_params[:rate])

        render json: {
            rate: RateSerializer.new(rate),
        }, status: :ok
    end

    def delete
        rate = Rate.find(rate_params[:id])

        unless rate
            head :not_found
        end

        rate.destroy

        head :ok
    end

    private

    def rate_params
        params.permit(:id, :rate, :wine_id, :expert_id)
    end

    def handle_invalid_record(e)
        render json: { errors: e.record.errors.full_messages }, status: :unprocessable_entity
    end
end
