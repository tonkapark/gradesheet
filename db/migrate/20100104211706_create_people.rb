class CreatePeople < ActiveRecord::Migration
  def self.up
    create_table :people do |t|
      t.integer :school_id
      t.string :type
      t.string :code
      t.string :firstname
      t.string :middlename
      t.string :lastname
      t.string :generation
      t.string :gender
      t.date :dob
      t.string :primary_phone
      t.string :secondary_phone
      t.string :email

      t.timestamps
    end
        
    User.find(:all).each do |u|
       u.person = case u.type_old
        when "Administrator"
          Administrator.create(:school_id => 1, :code => u.school_number, :firstname => u.first_name, :lastname => u.last_name, :email => u.email)
        when "Teacher"
          Teacher.create(:school_id => 1, :code => u.school_number, :firstname => u.first_name, :lastname => u.last_name, :email => u.email)
        when "Student"
          Student.create(:school_id => 1, :code => u.school_number, :firstname => u.first_name, :lastname => u.last_name, :email => u.email)
        when "TeacherAssistant"
          TeacherAssistant.create(:school_id => 1, :code => u.school_number, :firstname => u.first_name, :lastname => u.last_name, :email => u.email)          
        else
          Person.create(:school_id => 1, :type => u.type_old,  :code => u.school_number, :firstname => u.first_name, :lastname => u.last_name, :email => u.email)          
        end
        u.save
    end    
      
    add_index :people, [:code, :school_id], :unique => true
    add_index :people, :lastname
    add_index :people, :type
    
  end

  def self.down
    drop_table :people
  end
end
