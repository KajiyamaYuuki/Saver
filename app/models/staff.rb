class Staff < ApplicationRecord
  belongs_to :shop
  enum sex: { man: 1, woman: 2 }
end
