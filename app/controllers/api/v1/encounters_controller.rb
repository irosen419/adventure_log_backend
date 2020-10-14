class Api::V1::EncountersController < ApplicationController
    before_action :find_encounter, only: [:show, :update, :destroy]

    def show
        render json: { encounter: EncounterSerializer.new(@encounter) }, status: :accepted
    end

    def create
        encounter = Encounter.create(encounter_params.to_h)
        # byebug
        if params[:encounter][:images]
            params[:encounter][:images].each do |image|
                encounter.images.attach(image[1])
            end
            encounter.photos = encounter.images.map{|image| url_for(image)}
            # encounter.img_url = rails_blob_url(encounter.photo)
            encounter.save
        end
        if encounter.valid?
            render json: { encounter: EncounterSerializer.new(encounter) }, status: :created
        else
            render json: { error: 'Failed to create encounter' }, status: :not_acceptable
        end
    end

    def update
        # byebug
        @encounter.update(encounter_params)
        if params[:encounter][:photo]
            encounter.img_url = rails_blob_url(encounter.photo)
            encounter.save
        end
        if @encounter.valid?
            render json: { encounter: EncounterSerializer.new(@encounter) }, stats: :accepted
        else
            render json: { error: 'Failed to update encounter' }, status: :not_acceptable
        end
    end

    def destroy
        @encounter.destroy
        if !@encounter.save
            render json: { success: "Deleted encounter" }, status: :accepted
        else
            render json: {error: 'Failed to delete encounter', encounter: @encounter}, status: :not_acceptable
        end
    end

    private

    def find_encounter
        @encounter = Encounter.find(params[:id])
    end

    def encounter_params
        params.require(:encounter).permit(:trip_id, :animal_id, :time_of_day, :weather_conditions, :notes, images: [])
    end
end