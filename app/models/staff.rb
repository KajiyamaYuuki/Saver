class Staff < ApplicationRecord
  belongs_to :shop
  enum sex: {
    選択なし: 0,
    男性: 1,
    女性: 2
  }
end
