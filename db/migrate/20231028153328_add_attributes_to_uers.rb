class AddAttributesToUers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :activation_digest, :string
    add_column :users, :activated, :boolean, default: false 
    add_column :users, :activated_at, :datetime
    add_column :users, :remember_digest, :string

    add_index :users, :username, unique: true 
    add_index :users, :email, unique: true
  end
end
