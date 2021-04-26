class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :menu
  validates :start_scheduled_at, presence: true
  validates :end_scheduled_at, presence: true
  validate :date_before_start
  validate :date_before_finish



  def date_before_start
    return if start_scheduled_at.blank?
    errors.add(:start_scheduled_at, "は現在時刻以降を選択してください") if self.start_scheduled_at < Time.now
  end

  def date_before_finish
    return if end_scheduled_at.blank? || start_scheduled_at.blank?
    errors.add(:end_scheduled_at, "は開始日以降を選択してください") if self.end_scheduled_at < self.start_scheduled_at
  end
end
