class CreateAvailableTimes < ActiveRecord::Migration[7.2]
  def change
    create_table :available_times do |t|
      t.text :weekday, null: false
      t.time :available_time_slot, null: false
      t.references :clinic, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
