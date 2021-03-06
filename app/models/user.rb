class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :name, presence: true, length: { maximum: 30 }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: true
  before_validation { email.downcase! }
  mount_uploader :image, ImageUploader
  has_one :shop, dependent: :destroy
  has_many :reservations, dependent: :destroy
  has_many :reviews, dependent: :destroy
  before_update :must_not_update_last_admin_user
  before_destroy :must_not_destroy_last_admin_user

  def must_not_destroy_last_admin_user
    throw(:abort) if User.where(is_admin: true).count == 1 && self.is_admin == true
  end

  def must_not_update_last_admin_user
    throw(:abort) if User.where(is_admin: true).count == 1 && !self.is_admin && self.is_admin_was
  end
end
