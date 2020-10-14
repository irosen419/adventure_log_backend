class Api::V1::FriendshipsController < ApplicationController
    def friends
        friendships = Friendship.where(follower_id: params[:follower_id])
        render json: friendships
    end

    def create
        friendship = Friendship.create(friendship_params)

        if friendship.valid?
            render json: { friendship: FriendshipSerializer.new(friendship) }, status: :created
        else
            render json: { error: 'failed to create friendship' }, status: :not_acceptable
        end
    end

    private

    def friendship_params
        params.require(:friendship).permit(:follower_id, :following_id)
    end
end