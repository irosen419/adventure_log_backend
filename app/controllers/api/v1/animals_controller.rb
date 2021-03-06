class Api::V1::AnimalsController < ApplicationController
    def index
        animals = Animal.all
        render json: animals
    end

    def show
        animal = Animal.find(params[:id])
        render json: { animal: AnimalSerializer.new(animal) }, status: :accepted
    end

    def create
        animal = Animal.create(animal_params)

        if animal.valid?
            render json: { animal: AnimalSerializer.new(animal) }, status: :created
        else
            render json: { error: 'failed to create animal' }, status: :not_acceptable
        end
    end

    def update
        animal = Animal.find(params[:id])
        animal.update(animal_params)

        if animal.valid?
            render json: { animal: AnimalSerializer.new(animal) }, status: :updated
        else
            render json: { error: 'failed to create animal' }, status: :not_acceptable
        end
    end

    private

    def animal_params
        params.require(:animal).permit(:scientific_name, :common_name, :status)
    end
end