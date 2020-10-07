class Api::V1::TripsController < ApplicationController

    def show
        trip = Trip.find(params[:id])
        render json: trip
    end

    def create
        trip = Trip.create(trip_params)
        if trip.valid?
            render json: trip
        else
            render json: { error: 'failed to create trip' }
        end
    end

    private

    def trip_params
        params.require(:trip).permit(:user_id, :destination, :continent, :travel_date)
    end
end