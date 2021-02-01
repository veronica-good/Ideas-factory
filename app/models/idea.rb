class Idea < ApplicationRecord
    belongs_to :user, optional: true
    
    validates :title, presence: true, uniqueness: true
    validates :description, presence: true, length: {minimum: 50}
end
