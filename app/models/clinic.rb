class Clinic < ApplicationRecord
  validates :clinic_name, presence: true, length: { maximum: 255 }
  validates :doctor_name, presence: true, length: { maximum: 255 }

  has_many :available_times, dependent: :destroy
  has_many :appointments, dependent: :destroy
  has_many :visit_intervals, dependent: :destroy
  belongs_to :user

  accepts_nested_attributes_for :available_times, :visit_intervals

  before_validation :assign_user_to_available_times
  before_validation :assign_user_to_visit_intervals

  private

  def assign_user_to_available_times
    available_times.each do |available_time|
      available_time.user_id = self.user_id if available_time.user_id.nil?
    end
  end

  def assign_user_to_visit_intervals
    visit_intervals.each do |visit_interval|
      visit_interval.user_id = self.user_id if visit_interval.user_id.nil?
    end
  end
end
