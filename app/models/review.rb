class Review < ApplicationRecord
  belongs_to :user
  belongs_to :shop
  validates :score, presence: true
end
