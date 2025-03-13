class AddLocationToClinics < ActiveRecord::Migration[7.2]
  def change
    add_column :clinics, :address, :string
    add_column :clinics, :latitude, :decimal
    add_column :clinics, :longitude, :decimal
  end
end
