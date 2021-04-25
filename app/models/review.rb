class Review < ApplicationRecord
  belongs_to :user
  belongs_to :shop
  validates :content, presence: true
  validates :score, presence: true
end
