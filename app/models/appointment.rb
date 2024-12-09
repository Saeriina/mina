class Appointment < ApplicationRecord
  validates :appointment_date, presence: true
  validates :scheduled_time, presence: true
  validates :status, presence: true
  belongs_to :clinic
  belongs_to :user

  enum status: { pending: 0, confirmed: 1, cancelled: 2 }
end
