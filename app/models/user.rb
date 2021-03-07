class User < ApplicationRecord
    has_secure_password

    has_many :ideas, dependent: :nullify
    has_many :reviews, dependent: :nullify
    has_many :likes
    
    def full_name
        "#{first_name} #{last_name}"
    end
end
