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

  def auto_schedule
    @times = [ "12:00", "12:30", "13:00", "13:30", "14:00", "14:30", "15:00", "15:30", "16:00", "17:00", "18:00" ]
    # 2か月間のスケジュール期間
    start_date = Date.today
    end_date = start_date + 2.months

    # スケジュール表の日付と時間を取得
    schedule_dates = (start_date..end_date).to_a
    schedule_times = @times # 既存ロジックから時間リストを取得

    # 全クリニックの訪問可能時間と頻度を取得
    clinics = Clinic.includes(:available_times, :visit_intervals).all

    # クリニックごとの次回訪問可能日を計算
    next_visit_dates = clinics.map do |clinic|
      # クリニックの最後の訪問スケジュールを取得
      last_schedule = clinic.schedules.order(:appointment_date).last
      # 最後の訪問日を取得（スケジュールがない場合はnil）
      last_appointment_date = last_schedule&.appointment_date
      # 訪問頻度（日数）を取得
      visit_interval = clinic.visit_intervals.first&.interval

      # 次回訪問日を計算
      if last_appointment_date
        next_visit_date = last_appointment_date + visit_interval
      else
        next_visit_date = start_date + visit_interval
      end
      { clinic: clinic, next_visit_date: next_visit_date }
    end

    # スケジュールデータを保存
    schedule_dates.each do |date|
      weekday = date.wday

      schedule_times.each do |time|
        # 該当日時に訪問可能なクリニックを抽出
        available_clinics = next_visit_dates.select do |data|
          clinic = data[:clinic]
          next_visit_date = data[:next_visit_date]

            clinic.available_times.any? do |available_time|
              available_time.weekday == Date::DAYNAMES[weekday] &&
              available_time.available_time_slot == time
            end
        end
        # 訪問可能クリニックがある場合、スケジュールを保存
        if available_clinics.any?
          selected_clinic_data = available_clinics
          .select { |data| data[:next_visit_date] >= date } # 未来の日程のみ考慮
          .min_by { |data| (data[:next_visit_date] - date).abs }

          clinic = selected_clinic_data[:clinic]

          # スケジュールが未登録の場合のみ保存
          unless Schedule.exists?(appointment_date: date, scheduled_time: time)
            Schedule.create!(
              appointment_date: date,
              scheduled_time: time,
              clinic: clinic
             )
              # 次回訪問日を更新
              selected_clinic_data[:next_visit_date] = date + clinic.visit_intervals.first.interval.days
          end
        end
      end
    end
    # スケジュール作成後にタスク一覧ページへリダイレクト
    redirect_to tasks_path, notice: "スケジュールが自動作成されました。"
  end
end
