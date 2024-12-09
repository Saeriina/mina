class CreateVisitIntervals < ActiveRecord::Migration[7.2]
  def change
    create_table :visit_intervals do |t|
      t.integer :interval, null: false
      t.references :clinic, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
