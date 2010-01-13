class CreateEdu < ActiveRecord::Migration
  def self.up

    create_table :assignment_categories, :force => true do |t|
      t.integer :school_id, :null => false
      t.string   :name
      t.timestamps      
    end

    add_index :assignment_categories, [:school_id]
    
    create_table :assignment_evaluations, :force => true do |t|
      t.integer :school_id, :null => false
      t.integer  :assignment_id, :null => false
      t.integer  :enrollment_id, :null => false
      t.integer  :student_id
      t.string   :points_earned
      t.timestamps
    end

    add_index :assignment_evaluations, [:school_id]
    add_index :assignment_evaluations, [:enrollment_id]
    add_index :assignment_evaluations, [:student_id, :assignment_id], :unique => true

    create_table :assignments, :force => true do |t|
      t.integer :school_id, :null => false
      t.integer  :course_term_id, :null => false
      t.string   :name      
      t.integer  :assignment_category_id
      t.float    :possible_points
      t.datetime :due_date
      t.timestamps      
    end

    add_index :assignments, [:school_id]
    add_index :assignments, [:assignment_category_id]
    add_index :assignments, [:course_term_id]

    create_table :buildings, :force => true do |t|
      t.integer :school_id, :null => false
      t.integer  :site_id, :null => false
      t.string   :name
      t.integer  :rooms_count, :default => 0
      t.timestamps
      
    end

    add_index :buildings, [:school_id]
    add_index :buildings, [:site_id]

    create_table :comments, :force => true do |t|
      t.integer :school_id, :null => false
      t.integer  :user_id
      t.string   :commentable_id
      t.string   :commentable_type
      t.text     :content
      t.boolean  :active
      t.integer  :position
      t.timestamps
      
    end

    add_index :comments, [:school_id]
    add_index :comments, [:user_id]

    create_table :course_term_skills, :force => true do |t|
      t.integer :school_id, :null => false
      t.integer  :course_term_id
      t.integer  :objective_id
      t.timestamps
      
    end

    add_index :course_term_skills, [:school_id]
    add_index :course_term_skills, [:course_term_id]
    add_index :course_term_skills, [:objective_id]

    create_table :course_terms, :force => true do |t|
      t.integer :school_id, :null => false
      t.integer  :term_id, :null => false
      t.integer  :course_id, :null => false
      t.string   :code            
      t.integer  :teacher_id
      t.integer  :room_id
      t.integer  :seats
      t.integer  :teacher_assistant_id      
      t.integer  :grading_scale_id
      t.integer  :enrollments_count,    :default => 0
      t.timestamps
    end

    add_index :course_terms, [:school_id]
    add_index :course_terms, [:code]
    add_index :course_terms, [:course_id]
    add_index :course_terms, [:room_id]
    add_index :course_terms, [:term_id]
    add_index :course_terms, [:grading_scale_id]

    create_table :courses, :force => true do |t|
      t.integer :school_id, :null => false
      t.string   :code
      t.string   :name      
      t.timestamps
    end

    add_index :courses, [:school_id]
    add_index :courses, [:school_id, :code], :unique => true    

    create_table :date_ranges, :force => true do |t|
      t.integer :school_id, :null => false
      t.string   :type
      t.string   :name
      t.string   :description
      t.date     :begin_date
      t.date     :end_date
      t.integer  :school_year_id
      t.boolean  :active
      t.timestamps
      
    end
    
    add_index :date_ranges, [:school_id]
    add_index :date_ranges, [:school_year_id]

    create_table :enrollments, :force => true do |t|
      t.integer :school_id, :null => false
      t.integer  :student_id, :null => false
      t.integer   :course_term_id, :null => false
      t.integer :course_id
      t.string   :grade
      t.datetime :graded_at
      t.float    :total_points_earned, :default => 0.0      
      t.boolean  :accommodation,       :default => false
      t.timestamps
    end

    add_index :enrollments, [:school_id]
    add_index :enrollments, [:course_id]
    add_index :enrollments, [:course_term_id]
    add_index :enrollments, [:student_id]
    add_index :enrollments, [:course_term_id, :student_id], :unique => true

    create_table :grading_scales, :force => true do |t|
      t.integer :school_id, :null => false
      t.string   :name
      t.boolean  :active,      :default => true
      t.boolean  :simple_view, :default => false
      t.timestamps
    end
    
    add_index :grading_scales, [:school_id]

    create_table :grading_skills, :force => true do |t|
      t.integer :school_id, :null => false
      t.integer  :course_id, :null => false
      t.string   :symbol
      t.string   :description
      t.boolean  :active
      t.integer  :position
      t.timestamps      
    end

    add_index :grading_skills, [:school_id]
    add_index :grading_skills, [:course_id]

    create_table :rooms, :force => true do |t|
      t.integer :school_id, :null => false
      t.integer  :building_id, :null => false
      t.string   :name
      t.integer  :seats
      t.timestamps
      
    end
    
    add_index :rooms, [:school_id]
    add_index :rooms, [:building_id]

    create_table :scale_ranges, :force => true do |t|
      t.integer  :grading_scale_id
      t.string   :description
      t.float    :max_score
      t.float    :min_score
      t.string   :letter_grade, :null => false
      t.integer  :position
      t.timestamps      
    end
    
    add_index :scale_ranges, [:grading_scale_id]

    create_table :schools, :force => true do |t|
      t.string   :name
      t.timestamps
      
    end

    create_table :sites, :force => true do |t|
      t.integer  :school_id, :null => false
      t.string   :name      
      t.timestamps
      
    end

    add_index :sites, [:school_id]

    create_table :topics, :force => true do |t|
      t.integer :school_id, :null => false
      t.string   :name
      t.boolean  :active,     :default => true
      t.integer  :position
      t.integer  :objectives_count, :default => 0
      t.timestamps      
    end
    
    add_index :topics, [:school_id]
    
    create_table :objective_evaluations, :force => true do |t|
      t.integer :school_id, :null => false
      t.integer  :student_id, :null => false
      t.integer  :course_term_skill_id
      t.string   :score
      t.boolean  :completed,  :default => false
      t.timestamps      
    end

    add_index :objective_evaluations, [:school_id]
    add_index :objective_evaluations, [:course_term_skill_id]
    add_index :objective_evaluations, [:student_id]

    create_table :objectives, :force => true do |t|      
      t.integer  :topic_id
      t.string   :description
      t.boolean  :active      
      t.integer  :position      
      t.timestamps      
    end    
    add_index :objectives, [:topic_id]
    
    create_table :people, :force => true do |t|
      t.integer  :school_id, :null => false
      t.string  :type, :null => false
      t.string   :code
      t.string   :firstname
      t.string   :middlename
      t.string   :lastname
      t.string   :generation
      t.string   :gender
      t.date     :dob
      t.string   :primary_phone
      t.string   :secondary_phone
      t.string   :email
      t.timestamps      
    end
    
    add_index :people, [:school_id]    
    add_index :people, [:lastname]
    add_index :people, [:code]
      
    create_table :users, :force => true do |t|
      t.integer :school_id, :null => false
      t.string   :email
      t.string   :encrypted_password, :limit => 128
      t.string   :salt,               :limit => 128
      t.string   :confirmation_token, :limit => 128
      t.string   :remember_token,     :limit => 128
      t.boolean  :email_confirmed,                   :default => false, :null => false
      t.boolean  :admin,                             :default => false, :null => false
      t.integer  :person_id
      t.timestamps
      
    end

    add_index :users, [:school_id]
    add_index :users, [:email]
    add_index :users, [:id, :confirmation_token]
    add_index :users, [:person_id]
    add_index :users, [:remember_token]
    
  end

  def self.down
    drop_table :assignment_categories
    drop_table :assignment_evaluations
    drop_table :assignments
    drop_table :buildings
    drop_table :comments
    drop_table :course_term_skills
    drop_table :course_terms
    drop_table :courses
    drop_table :date_ranges
    drop_table :enrollments
    drop_table :grading_scales
    drop_table :grading_skills
    drop_table :people
    drop_table :person_roles
    drop_table :roles
    drop_table :rooms
    drop_table :scale_ranges
    drop_table :schools
    drop_table :sites
    drop_table :topics
    drop_table :objective_evaluations
    drop_table :objectives
    drop_table :users
  end
end
