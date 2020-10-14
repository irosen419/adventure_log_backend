class FriendshipSerializer < ActiveModel::Serializer
    attributes :id, :follower_id, :following_id
end