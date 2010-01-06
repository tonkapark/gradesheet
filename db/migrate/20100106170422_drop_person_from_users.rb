class DropPersonFromUsers < ActiveRecord::Migration
  def self.up
    remove_column :users, :type
    remove_column :users, :site_id
    remove_column :users, :short_name
    remove_column :users, :class_of
    remove_column :users, :homeroom
    remove_column :users, :school_number
  end

  def self.down
    add_column :users, :type, :string
    add_column :users, :site_id, :integer
    add_column :users, :short_name, :string
    add_column :users, :class_of, :integer
    add_column :users, :homeroom, :string
    add_column :users, :school_number, :string
  end
end
