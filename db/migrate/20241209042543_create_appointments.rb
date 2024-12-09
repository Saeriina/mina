class CreateAppointments < ActiveRecord::Migration[7.2]
  def change
    create_table :appointments do |t|
      t.date :appointment_date, null: false
      t.time :scheduled_time, null: false
      t.integer :status, null: false, default: 0
      t.references :clinic, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
