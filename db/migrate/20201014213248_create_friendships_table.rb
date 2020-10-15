class CreateFriendshipsTable < ActiveRecord::Migration[6.0]
  def change
    create_table :friendships do |t|
      t.bigint :follower_id
      t.bigint :following_id
    end
  end
end
