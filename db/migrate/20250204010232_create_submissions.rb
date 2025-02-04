class CreateSubmissions < ActiveRecord::Migration[7.2]
  def change
    create_table :submissions do |t|
      t.string :title, null: false
      t.string :description, null: false
      t.date :due_date, null: false
      t.references :user, null: false, foreign_key: true
      t.timestamps
    end
  end
end
