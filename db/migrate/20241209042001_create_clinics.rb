class CreateClinics < ActiveRecord::Migration[7.2]
  def change
    create_table :clinics do |t|
      t.string :clinic_name, null: false
      t.string :doctor_name, null: false
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
