class AddIndexesToFriendships < ActiveRecord::Migration[6.0]
  def change
    add_index :friendships, [:follower_id , :following_id], unique: true
  end
end
