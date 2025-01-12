class TasksController < ApplicationController
  def index
    @dates = (0..60).map { |i| Date.today + i }
    @mon = AvailableTime
         .where("weekday LIKE :weekday", weekday: "%Mon%")
         .where("available_time_slot LIKE :time_slot", time_slot: "%12:00%")
  end

  def new
    @dates = (0..60).map { |i| Date.today + i }
    @mon = AvailableTime
         .where("weekday LIKE :weekday", weekday: "%Mon%")
         .where("available_time_slot LIKE :time_slot", time_slot: "%12:00%")
  end

  def create
    input_clinic_name = params[:clinic_name]
    matching_clinic = Clinic.find_by(clinic_name: input_clinic_name)

    if matching_clinic
      clinic = Clinic.find(params[:clinic_id])
      @schedule = clinic.schedules.build(schedule_params)

      if @schedule.save
        redirect_to tasks_path, notice: "スケジュールが保存されました"
      else
        render :new, status: :unprocessable_entitycd
      end
    end
  end
 private

  def schedule_params
    params.require(:schedule).permit(:appointment_date, :scheduled_time)
  end
end
