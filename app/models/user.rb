class User < ApplicationRecord
    has_many :trips, :dependent => :delete_all

    has_many :received_follows, foreign_key: :following_id, class_name: "Follow"
    has_many :followers, through: :received_follows, source: :follower

    has_many :given_follows, foreign_key: :follower_id, class_name: "Follow"
    has_many :followings, through: :given_follows, source: :following

    validates :username, uniqueness: true
    validates :username, :password, :password_confirmation, presence: true

    has_secure_password
end
