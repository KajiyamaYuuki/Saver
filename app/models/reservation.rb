class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :menu
  validates :start_scheduled_at, presence: true
  validates :end_scheduled_at, presence: true
end
