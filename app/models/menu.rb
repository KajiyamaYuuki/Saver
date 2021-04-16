class Menu < ApplicationRecord
  belongs_to :shop
  has_many :reservations, dependent: :destroy
end
