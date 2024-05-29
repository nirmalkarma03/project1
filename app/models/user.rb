class User < ApplicationRecord
    has_secure_password
    enum gender: [:male, :female]
end