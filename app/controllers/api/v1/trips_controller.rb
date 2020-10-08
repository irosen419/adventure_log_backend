class Api::V1::TripsController < ApplicationController

    def show
        trip = Trip.find(params[:id])
        render json: { trip: TripSerializer.new(trip) }, status: :accepted
    end

    def create
        trip = Trip.create(trip_params)
        if trip.valid?
            render json: { trip: TripSerializer.new(trip) }, status: :created
        else
            render json: { error: 'failed to create trip' }, status: :not_acceptable
        end
    end

    private

    def trip_params
        params.require(:trip).permit(:user_id, :destination, :continent, :travel_date)
    end
end