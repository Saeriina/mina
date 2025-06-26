class TasksController < ApplicationController
  before_action :delete_expired_submissions, only: :index
  before_action :set_times, only: [ :index, :new, :create, :auto_schedule ]

    DAY_MAPPING = {
      "Sun" => "日",
      "Mon" => "月",
      "Tue" => "火",
      "Wed" => "水",
      "Thu" => "木",
      "Fri" => "金",
      "Sat" => "土"
    }.freeze

  def index
    # 表示する日付を生成
    @dates = (0..6).map { |i| Date.today + i }

    # 自分が登録したクリニックのIDを取得
    my_clinic_ids = current_user.clinics.pluck(:id)
    # スケジュールデータを取得
    @schedules = Schedule.includes(:clinic).where(clinic_id: my_clinic_ids, appointment_date: @dates)

    # 提出物のデータを取得
    @submissions = Submission.includes(:user).where(user_id: current_user.id)
  end

  def new
    # 表示する日付を生成
    @dates = (0..60).map { |i| Date.today + i }
    my_clinic_ids = current_user.clinics.pluck(:id)
    @schedules = Schedule.includes(:clinic).where(clinic_id: my_clinic_ids, appointment_date: @dates)
  end

  def create
    @dates = (0..60).map { |i| Date.today + i }
    @schedules = Schedule.includes(:clinic).where(appointment_date: @dates)

    input_clinic_name = params[:clinic_name]
    matching_clinic = current_user.clinics.find_by(clinic_name: input_clinic_name) # 保存されているクリニックかを確認

    if matching_clinic
      # フォームから送信された値を取得
      appointment_date = params[:appointment_date]
      scheduled_time = params[:scheduled_time]

      # 日付から曜日を取得してマッピング
      appointment_weekday = Date.parse(appointment_date).strftime("%a") # 例: "Mon"
      available_weekday = DAY_MAPPING[appointment_weekday] # 例: "月"

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
          redirect_to tasks_path, success: "スケジュールが作成されました。"
        else
          # 保存失敗時の処理
          flash.now[:danger] = "スケジュールの保存に失敗しました"
          render :new, status: :unprocessable_entity
        end
      else
        # AvailableTimeが存在しない場合
        flash.now[:danger] = "指定された日時は面会不可です"
        render :new, status: :unprocessable_entity
      end
    else
      # クリニックが見つからない場合
      flash.now[:danger] = "指定されたクリニックが見つかりません"
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    # スケジュールを検索
    schedule = Schedule.find(params[:id])

    # スケジュールを削除
    if schedule.destroy
      redirect_to tasks_path, success: "スケジュールを削除しました"
    else
      redirect_to tasks_path, alert: "スケジュールの削除に失敗しました"
    end
  end

  def auto_schedule
    # 2か月間のスケジュール期間
    start_date = Date.today
    end_date = start_date + 2.months

    # スケジュール表の日付と時間を取得
    schedule_dates = (start_date..end_date).to_a
    schedule_times = @times # 既存ロジックから時間リストを取得

    # 全クリニックの訪問可能時間と頻度を取得
    clinics = current_user.clinics.includes(:available_times, :visit_intervals).all

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
        next_visit_date = nil
        (start_date..(start_date + 7.days)).each do |d|
          wday_en = Date::ABBR_DAYNAMES[d.wday]    # 例: "Mon"
          wday_ja = DAY_MAPPING[wday_en]           # 例: "月"

          match = clinic.available_times.find { |at| at.weekday == wday_ja }
          if match
            next_visit_date = d
            break
          end
        end
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

          (0..6).any? do |offset|
            target_date = next_visit_date + offset
            target_weekday = DAY_MAPPING[target_date.strftime("%a")]

            target_date == date && clinic.available_times.any? do |available_time|
                available_time.weekday == target_weekday &&
                available_time.available_time_slot == time
            end
          end
        end
        # 訪問可能クリニックがある場合、スケジュールを保存
        if available_clinics.any?
          selected_clinic_data = available_clinics.first
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
    redirect_to tasks_path, success: "スケジュールが自動作成されました。"
  end

  def delete_expired_submissions
    Submission.where("due_date < ?", Date.today).destroy_all
  end

  def set_times
    @times = [ "12:00", "12:30", "13:00", "13:30", "14:00", "14:30", "15:00", "15:30", "16:00", "17:00", "18:00" ]
  end
end
