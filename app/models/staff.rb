class Staff < ApplicationRecord
  belongs_to :shop
  validates :name, presence: true, length: { maximum: 30 }
  validates :sex, presence: true
  enum sex: { man: 1, woman: 2 }
end
