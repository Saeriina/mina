class CreateProducts < ActiveRecord::Migration[7.2]
  def change
    create_table :products do |t|
      t.string :product_name, null: false
      t.string :diagnosis, null: false
      t.string :product_number, null: false
      t.references :user, null: false, foreign_key: true
      t.timestamps
    end
  end
end
