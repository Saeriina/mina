class TasksController < ApplicationController
  def index
    @mon = AvailableTime.where("weekday LIKE ?", "%Mon%").where("available_time_slot LIKE ?", "%12:00%")
  end

  def new
    @dates = (1..60).map { |i| Date.today + i }
    @mon = AvailableTime.where("weekday LIKE ?", "%Mon%").where("available_time_slot LIKE ?", "%12:00%")
  end

  def create
  end
end

private

  def find_clinics_by_weekday
    today_weekday = Date.today.strftime("%a")
    clinics = Clinic.joins(:available_times)
                  .where(available_times: { weekday: "Mon" })
                  .distinct
  end
