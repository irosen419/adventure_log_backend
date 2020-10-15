class AddIndexesToFriendshipsAgain < ActiveRecord::Migration[6.0]
  def change
    add_index :friendships, [:following_id , :follower_id], unique: true
  end
end
