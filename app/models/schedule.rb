class Schedule < ApplicationRecord
  validates :appointment_date, presence: true
  validates :scheduled_time, presence: true, length: { maximum: 255 }

  belongs_to :clinic
end
