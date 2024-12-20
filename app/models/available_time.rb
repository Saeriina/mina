class AvailableTime < ApplicationRecord
  validate :validate_weekdays
  validates :available_time_slot, presence: true

  belongs_to :clinic


  private

  def validate_weekdays
    valid_days = %w[ Monday Tuesday Wednesday Thursday Friday ]
    visitable_days = weekday.is_a?(String) ? JSON.parse(weekday) : weekday

    invalid_days = visitable_days - valid_days
    if invalid_days.any?
      errors.add(:weekday, "に無効な曜日が含まれています: #{invalid_days.join(', ')}")
    end
  end
end
