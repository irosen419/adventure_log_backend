class Api::V1::UsersController < ApplicationController
    skip_before_action :authorized, only: [:create]

    before_action :find_user, only: [:show, :update, :destroy]

    def profile
        render json: { user: UserSerializer.new(current_user) }, status: :accepted
    end

    def index
        users = User.all
        render json: {users: users.map {|user| UserSerializer.new(user)}}, status: :accepted
    end

    def show
        render json: { user: UserSerializer.new(@user) }, status: :accepted
    end

    def trips
        trips = Trip.where(user_id: [params[:id]])
        render json: trips
    end

    def friendship
        friendship = Friendship.create(friendship_params)
        user = User.find(friendship[:following_id])

        if friendship.valid?
            render json: {user: UserSerializer.new(user)}
        else
            render json: { error: 'Failed to foster friendship' }, status: :not_acceptable
        end
    end

    def unfriend
        friendship = Friendship.find_by(follower_id: params[:friendship][:follower_id], following_id: params[:friendship][:following_id])
        friendship.destroy
        if !friendship.save
            render json: { success: "Successfully unfriended this person" }, status: :accepted
        else
            render json: { error: "Failed to unfriend user" }, status: :not_acceptable
        end
    end

    def followings
        user = User.find(params[:id])
        render json: { followings: UserSerializer.new(user).followings }, status: :accepted
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

    def friendship_params
        params.require(:friendship).permit(:follower_id, :following_id)
    end
end