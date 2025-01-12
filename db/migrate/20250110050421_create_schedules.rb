class CreateSchedules < ActiveRecord::Migration[7.2]
  def change
    create_table :schedules do |t|
      t.date :appointment_date, null: false
      t.string :scheduled_time, null: false
      t.references :clinic, null: false, foreign_key: true

      t.timestamps
    end
  end
end
