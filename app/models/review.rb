class Review < ApplicationRecord
  belongs_to :user
  belongs_to :shop
  validates :content, presence: true
  validates :score, presence: true, numericality: {only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 5}
end
