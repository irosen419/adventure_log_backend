class User < ApplicationRecord
    has_many :trips, :dependent => :delete_all

    validates :username, uniqueness: true
    validates :username, :password, :password_confirmation, presence: true

    has_secure_password
end
