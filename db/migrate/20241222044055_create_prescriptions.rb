class CreatePrescriptions < ActiveRecord::Migration[7.2]
  def change
    create_table :prescriptions do |t|
      t.integer :quantity, null: false
      t.decimal :ratio, null: false
      t.references :clinic, null: false, foreign_key: true
      t.references :product, null: false, foreign_key: true
      t.timestamps
    end
  end
end
