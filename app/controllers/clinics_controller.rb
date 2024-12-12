class ClinicsController < ApplicationController
  def new
    @clinic = Clinic.new
    @clinic.available_times.build # 空のAvailableTimeを用意
    @clinic.visit_intervals.build # 空のVisitIntervalを用意
  end

  def index
    @clinics = Clinic.includes(:user)
  end

  def create
    @clinic = current_user.clinics.build(clinic_params)
    if @clinic.save
      redirect_to clinics_path, success: "#{Clinic.model_name.human}が作成されました。"           
    else
      flash.now[:danger] = "#{Clinic.model_name.human}の作成に失敗しました。"
      render :new, status: :unprocessable_entity
    end
  end

  private

  def clinic_params
    params.require(:clinic).permit(:clinic_name, :doctor_name,
    available_times_attributes: [:available_time_slot, weekday: []],
    visit_intervals_attributes: [:interval],
  )
  end
end
