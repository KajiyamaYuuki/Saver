class Menu < ApplicationRecord
  belongs_to :shop
  has_many :reservations, dependent: :destroy
  validates :title, presence: true, length: { maximum: 30 }
  validates :price, presence: true
  validates :interval_hour, presence: true
  validates :reservationable, presence: true
  mount_uploader :image, ImageUploader
end
