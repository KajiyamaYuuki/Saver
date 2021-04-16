class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :name, presence: true
  mount_uploader :image, ImageUploader
  has_one :shop, dependent: :destroy
  has_many :reservations, dependent: :destroy
end
