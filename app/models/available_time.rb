class AvailableTime < ApplicationRecord
  validate :validate_weekdays
  validate :validate_times

  belongs_to :clinic


  private

  def validate_weekdays
    valid_days = %w[ Mon Tuesday Wednesday Thursday Friday ]
    visitable_days = weekday.is_a?(String) ? JSON.parse(weekday) : weekday

    invalid_days = visitable_days - valid_days
    if invalid_days.any?
      errors.add(:weekday, "に無効な曜日が含まれています: #{invalid_days.join(', ')}")
    end
  end

  def validate_times
    valid_times = %w[ 12:00 12:30 13:00 13:30 14:00 14:30 15:00 15:30 16:00 17:00 18:00 ]
    visitable_times = available_time_slot.is_a?(String) ? JSON.parse(available_time_slot) : available_time_slot

    invalid_times = visitable_times - valid_times
    if invalid_times.any?
      errors.add(:available_time_slot, "に無効な時間が含まれています: #{invalid_times.join(', ')}")
    end
  end
end
