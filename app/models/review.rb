class Review < ApplicationRecord
  belongs_to :user
  belongs_to :idea
  validates :body, presence: true, length: {minimum: 10}
end
