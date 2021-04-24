class Shop < ApplicationRecord
  has_many :staffs, dependent: :destroy
  has_many :menus, dependent: :destroy
  has_many :menu_reservations, through: :menus, source: :reservations
  has_many :reviews, dependent: :destroy
  belongs_to :user
  mount_uploader :image, ImageUploader

  validates :name, presence: true, length: { maximum: 30 }
  validates :post_code, presence: true, length: { maximum: 7 }
  validates :prefecture_code, presence: true
  validates :address_city, presence: true
  validates :address_street, presence: true
  validates :email, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: true
  before_validation { email.downcase! }

  include JpPrefecture
  jp_prefecture :prefecture_code

  def prefecture_name
    JpPrefecture::Prefecture.find(code: prefecture_code).try(:name)
  end

  def prefecture_name=(prefecture_name)
    self.prefecture_code = JpPrefecture::Prefecture.find(name: prefecture_name).code
  end

  def average_score
    unless self.reviews.empty?
      reviews.average(:score).round(1).to_f
    else
      0.0
    end
  end

  def review_score_percentage
    unless self.reviews.empty?
      reviews.average(:score).round(1).to_f*100/5
    else
      0.0
    end
  end

end
