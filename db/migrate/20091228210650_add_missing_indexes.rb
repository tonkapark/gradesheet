class AddMissingIndexes < ActiveRecord::Migration
  def self.up
    
    add_index :courses, :teacher_id
    add_index :courses, :grading_scale_id
    add_index :courses, :course_att_id
    add_index :users, :site_id
    add_index :enrollments, :student_id
    add_index :enrollments, :course_id
    add_index :assignments, :course_term_id
    add_index :assignments, :assignment_category_id
    add_index :date_ranges, :school_year_id
    add_index :sites, :school_id
    add_index :scale_ranges, :grading_scale_id
    add_index :grading_skills, :course_id
    add_index :supporting_skills, :supporting_skill_category_id
    add_index :supporting_skill_codes, :supporting_skill_id
    add_index :supporting_skill_evaluations, :student_id
    add_index :supporting_skill_evaluations, :course_term_skill_id
    add_index :course_term_skills, :course_term_id
    add_index :course_term_skills, :supporting_skill_id
    add_index :course_terms, :term_id
    add_index :course_terms, :course_id
    add_index :comments, :user_id
    
    
  end

  def self.down    
    remove_index :courses, :teacher_id
    remove_index :courses, :grading_scale_id
    remove_index :courses, :course_att_id
    remove_index :users, :site_id
    remove_index :enrollments, :student_id
    remove_index :enrollments, :course_id
    remove_index :assignments, :course_term_id
    remove_index :assignments, :assignment_category_id
    remove_index :date_ranges, :school_year_id
    remove_index :sites, :school_id
    remove_index :scale_ranges, :grading_scale_id
    remove_index :grading_skills, :course_id
    remove_index :supporting_skills, :supporting_skill_category_id
    remove_index :supporting_skill_codes, :supporting_skill_id
    remove_index :supporting_skill_evaluations, :student_id
    remove_index :supporting_skill_evaluations, :course_term_skill_id
    remove_index :course_term_skills, :course_term_id
    remove_index :course_term_skills, :supporting_skill_id
    remove_index :course_terms, :term_id
    remove_index :course_terms, :course_id
    remove_index :comments, :user_id  
  end
end
