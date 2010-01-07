class ClearanceCreateUsers < ActiveRecord::Migration
  def self.up
    create_table(:users) do |t|
      t.string   :email
      t.string   :encrypted_password, :limit => 128
      t.string   :salt,               :limit => 128
      t.string   :confirmation_token, :limit => 128
      t.string   :remember_token,     :limit => 128
      t.boolean  :email_confirmed, :default => false, :null => false
      t.boolean  :admin, :default => false, :null => false
      t.integer :person_id
      t.integer :invite_id
      t.timestamps
    end

    add_index :users, [:id, :confirmation_token]
    add_index :users, :email
    add_index :users, :remember_token
    add_index :users, :person_id
  end

  def self.down
    drop_table :users
  end
end
