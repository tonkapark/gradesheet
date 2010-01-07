class DropUsers < ActiveRecord::Migration
  def self.up
    drop_table :users
  end

  def self.down
    create_table :users do |t|
      t.string :login
      t.string  :first_name
      t.string  :last_name
      t.string  :email
      
      t.timestamps
    end    
    
    # Add new Authlogic columns
    add_column :users,  :crypted_password,    :string
    add_column :users,  :password_salt,       :string
    add_column :users,  :persistence_token,   :string
    add_column :users,  :single_access_token, :string
    add_column :users,  :perishable_token,    :string
    
    add_column :users,  :login_count,         :integer, :null => false, :default => 0
    add_column :users,  :failed_login_count,  :integer, :null => false, :default => 0
    add_column :users,  :last_request_at,     :datetime
    add_column :users,  :current_login_at,    :datetime
    add_column :users,  :last_login_at,       :datetime
    add_column :users,  :current_login_ip,    :string
    add_column :users,  :last_login_ip,       :string
    add_column :users,  :is_admin,            :boolean, :default => false
    
  end
end
