class Api::V1::AnimalsController < ApplicationController
    def index
        animals = Animal.all
        render json: animals
    end

    def create
        animal = Animal.create(animal_params)

        if animal.valid?
            render json: animal
        else
            render json: { error: 'failed to create animal' }
        end
    end

    private

    def animal_params
        params.require(:animal).permit(:scientific_name, :common_name)
    end
end