class AddUidToUsers < ActiveRecord::Migration[7.2]
  def change
    add_column :users, :uid, :string
    add_index :users, :uid
    add_column :users, :provider, :string
  end
end
