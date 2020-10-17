class Api::V1::TripsController < ApplicationController
    before_action :find_trip, only: [:show, :update, :destroy]

    def index
        trips = Trip.all.map{|trip| TripSerializer.new(trip)}
        render json: { trips: trips}, status: :accepted
    end

    def show
        render json: { trip: TripSerializer.new(@trip) }, status: :accepted
    end

    def create
        trip = Trip.create(trip_params)
        if trip.valid?
            render json: { trip: TripSerializer.new(trip) }, status: :created
        else
            render json: { error: 'Failed to create trip' }, status: :not_acceptable
        end
    end

    def encounters
        encounters = Encounter.where(trip_id: params[:id])
        render json: encounters
    end

    def update
        @trip.update(trip_params)
        if @trip.valid?
            render json: { trip: TripSerializer.new(@trip) }, stats: :accepted
        else
            render json: { error: 'Failed to update trip' }, status: :not_acceptable
        end
    end

    def destroy
        @trip.destroy
        if !@trip.save
            render json: { success: "Deleted trip" }, status: :accepted
        else
            render json: {error: 'Failed to delete trip', trip: @trip}, status: :not_acceptable
        end
    end

    private

    def find_trip
        @trip = Trip.find(params[:id])
    end

    def trip_params
        params.require(:trip).permit(:user_id, :destination, :continent, :travel_date)
    end
end