class Api::V1::UsersController < ApplicationController
    def index
        users = User.all
        render json: users
    end

    def show
        user = User.find(params[:id])
        render json: user
    end

    def trips
        trips = Trip.where(user_id: [params[:user_id]])
        render json: trips
    end

    def create
        user = User.create(user_params)
        if user.valid?
            render json: user
        else
            render json: { error: 'failed to create user' }
        end
    end

    private

    def user_params
        params.require(:user).permit(:username, :password, :password_confirmation)
    end
end