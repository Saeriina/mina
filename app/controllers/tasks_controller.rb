class TasksController < ApplicationController
  DAY_MAPPING = {
    "Monday" => "Monday",
    "Tuesday" => "Tuesday",
    "Wednesday" => "Wednesday",
    "Thursday" => "Thursday",
    "Friday" => "Friday"
  }.freeze

  def index
    # 表示する日付を生成
    @dates = (0..60).map { |i| Date.today + i }

    # スケジュールデータを取得
    @schedules = Schedule.includes(:clinic).where(appointment_date: @dates)

    # 表示する時間帯を定義
    @times = [ "12:00", "12:30", "13:00", "13:30", "14:00", "14:30", "15:00", "15:30", "16:00", "17:00", "18:00" ]
  end

  def new
    # 表示する日付を生成
    @dates = (0..60).map { |i| Date.today + i }

    @schedules = Schedule.includes(:clinic).where(appointment_date: @dates)
    # 表示する時間帯を定義
    @times = [ "12:00", "12:30", "13:00", "13:30", "14:00", "14:30", "15:00", "15:30", "16:00", "17:00", "18:00" ]
  end

  def create
    input_clinic_name = params[:clinic_name]
    matching_clinic = Clinic.find_by(clinic_name: input_clinic_name)

    if matching_clinic
      # フォームから送信された値を取得
      appointment_date = params[:appointment_date]
      scheduled_time = params[:scheduled_time]

      # 日付から曜日を取得してマッピング
      appointment_weekday = Date.parse(appointment_date).strftime("%A") # 例: "Monday"
      available_weekday = DAY_MAPPING[appointment_weekday] # 例: "Mon"

      # AvailableTimeの確認
      available_time = AvailableTime.where(
        clinic: matching_clinic,
        weekday: available_weekday,
        available_time_slot: scheduled_time
      ).exists?

      if available_time
        # スケジュールを作成
        @schedule = matching_clinic.schedules.build(
          appointment_date: appointment_date,
          scheduled_time: scheduled_time
        )

        if @schedule.save
          redirect_to tasks_path, notice: "スケジュールが保存されました"
        else
          # 保存失敗時の処理
          flash[:alert] = "スケジュールの保存に失敗しました: #{@schedule.errors.full_messages.join(', ')}"
          render :new, status: :unprocessable_entity
        end
      else
        # AvailableTimeが存在しない場合
        flash[:alert] = "指定された日時は面会不可です"
        redirect_to new_task_path
      end
    else
      # クリニックが見つからない場合
      flash[:alert] = "指定されたクリニックが見つかりません"
      redirect_to new_task_path
    end
  end

  def destroy
    # スケジュールを検索
    schedule = Schedule.find(params[:id])

    # スケジュールを削除
    if schedule.destroy
      redirect_to tasks_path, notice: "スケジュールを削除しました"
    else
      redirect_to tasks_path, alert: "スケジュールの削除に失敗しました"
    end
  end
end
