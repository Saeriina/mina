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
      puts @clinic.errors.full_messages
      flash.now[:danger] = "#{Clinic.model_name.human}の作成に失敗しました。"
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @clinic = Clinic.find(params[:id])
  end

  def edit
    @clinic = current_user.clinics.find(params[:id])
  end
  
  def destroy
    clinic = current_user.clinics.find(params[:id])
    clinic.destroy!
    redirect_to clinics_path, success: "#{Clinic.model_name.human}を削除しました。", status: :see_other
  end

  def update
    @clinic = current_user.clinics.find(params[:id])
    if @clinic.update(clinic_params)
      redirect_to clinic_path(@clinic), success: "#{Clinic.model_name.human}を更新しました。"
    else
      flash.now[:danger] = "#{Clinic.model_name.human}の更新に失敗しました。"
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def clinic_params
    params.require(:clinic).permit(:clinic_name, :doctor_name,
    available_times_attributes: [ :id, :available_time_slot, weekday: [] ],
    visit_intervals_attributes: [ :id, :interval ]
  )
  end
end
