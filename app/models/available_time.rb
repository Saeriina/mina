class AvailableTime < ApplicationRecord
  # アソシエーション
  belongs_to :clinic
  belongs_to :user

  # バリデーション
  validates :weekday, presence: true
  validates :available_time_slot, presence: true
end