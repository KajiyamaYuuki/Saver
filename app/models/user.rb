class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :name, presence: true
  mount_uploader :image, ImageUploader
  has_one :shop, dependent: :destroy
  has_many :reservations, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :conversations
  has_many :messages

  def rooms(user_id)
    Conversation.where(sender_id: user_id)
  end
end
