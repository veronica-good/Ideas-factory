class Idea < ApplicationRecord
    belongs_to :user, optional: true
    has_many :reviews, dependent: :nullify
    
    has_many :likes
    has_many :likers, through: :likes  , source: :user

    
    validates :title, presence: true, uniqueness: true
    validates :description, presence: true, length: {minimum: 50}
end
