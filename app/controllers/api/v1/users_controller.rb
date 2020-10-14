class Api::V1::UsersController < ApplicationController
    skip_before_action :authorized, only: [:create]

    before_action :find_user, only: [:show, :update, :destroy]

    def profile
        render json: { user: UserSerializer.new(current_user) }, status: :accepted
    end

    def index
        users = User.all
        render json: users
    end

    def show
        render json: { user: UserSerializer.new(@user) }, stats: :accepted
    end

    def trips
        trips = Trip.where(user_id: [params[:id]])
        render json: trips
    end

    def follow(username)
        user = User.find_by(username: username)
        Friendship.create(follower_id: self.id, following_id: user.id)
    end

    def create
        user = User.create(user_params)
        if user.valid?
            @token = encode_token(user_id: user.id)
            render json: { user: UserSerializer.new(user), jwt: @token }, status: :created
        else
            render json: { error: 'Failed to create user' }, status: :not_acceptable
        end
    end

    def update
        @user.update(user_params)
        if @user.valid?
            render json: { user: UserSerializer.new(user) }, stats: :accepted
        else
            render json: { error: 'Failed to update user' }, status: :not_acceptable
        end
    end

    def destroy
        @user.destroy
        if !@user.save
            render json: { success: "Deleted user" }, status: :accepted
        else
            render json: {error: 'Failed to delete user', user: user}, status: :not_acceptable
        end
    end

    private

    def find_user
        @user = User.find(params[:id])
    end

    def user_params
        params.require(:user).permit(:username, :password, :password_confirmation)
    end
end