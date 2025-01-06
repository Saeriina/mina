class TasksController < ApplicationController
  def index
    @mon = AvailableTime
         .where("weekday LIKE :weekday", weekday: "%Mon%")
         .where("available_time_slot LIKE :time_slot", time_slot: "%12:00%")
  end

  def new
    @dates = (1..60).map { |i| Date.today + i }
    @mon = AvailableTime
         .where("weekday LIKE :weekday", weekday: "%Mon%")
         .where("available_time_slot LIKE :time_slot", time_slot: "%12:00%")
  end

  def create
  end
end
