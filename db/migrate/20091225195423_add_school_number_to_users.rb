class AddSchoolNumberToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :school_number, :string
    add_index :users, :school_number, :name => :users_school_number_ix
  end

  def self.down
    remove_column :users, :school_number
  end
end
