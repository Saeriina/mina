class Clinic < ApplicationRecord
  validates :clinic_name, presence: true, length: { maximum: 255 }
  validates :doctor_name, presence: true, length: { maximum: 255 }

  has_many :available_times, dependent: :destroy
  accepts_nested_attributes_for :available_times
  has_many :appointments, dependent: :destroy
  has_many :visit_intervals, dependent: :destroy
  accepts_nested_attributes_for :visit_intervals
  belongs_to :user
end
