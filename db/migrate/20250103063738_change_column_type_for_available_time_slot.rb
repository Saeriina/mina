class ChangeColumnTypeForAvailableTimeSlot < ActiveRecord::Migration[7.2]
  def change
    remove_column :available_times, :available_time_slot
    add_column :available_times, :available_time_slot, :text
  end
end
