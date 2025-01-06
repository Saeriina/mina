class ChangeColumnTypeForAvailableTimes < ActiveRecord::Migration[7.2]
  def change
    change_column :available_times, :available_time_slot, :text
  end
end
