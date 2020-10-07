class Api::V1::EncountersController < ApplicationController

    def show
        encounter = encounter.find(params[:id])
        render json: { encounter: EncounterSerializer.new(encounter) }, status: :accepted
    end

    def create
        encounter = Encounter.create(encounter_params)
        if encounter.valid?
            render json: { encounter: EncounterSerializer.new(encounter) }, status: :created
        else
            render json: { error: 'failed to create encounter' }, status: :not_acceptable
        end
    end

    private

    def encounter_params
        params.require(:encounter).permit(:trip_id, :animal_id, :time_of_day, :weather_conditions, :notes)
    end
end