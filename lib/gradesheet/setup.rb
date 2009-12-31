module Gradesheet
  class Setup
    class << self
 
      def bootstrap
        new.bootstrap
      end 
      
      def load_sample_data
        new.load_sample_data
      end       

    end 

    
    # Loads the default data
    # Raises a RecordNotSaved exception if something goes wrong
    def bootstrap
          
      Site.transaction do
        # Site Data
        site = Site.create!(:name => 'Default Campus', :school_id => 1)

        # Administrator user
        Administrator.create!(:login => 'admin', :first_name => 'Admin', :last_name => 'Admin',
                     :site => site, :is_admin => true, :password_salt => Authlogic::Random.hex_token,
                     :password => 'admin', :password_confirmation => 'admin', :email => 'admin@example.com')
      end
    end

    def load_sample_data
      
      [Course, AssignmentCategory, SupportingSkill, SupportingSkillCategory, ScaleRange, GradingScale, Term, SchoolYear, Student, Site].each(&:delete_all)
      
      site = Site.create!(:name => Populator.words(1..3).titleize, :school_id => 1)
      
      AssignmentCategory.create!(:name => 'Homework')
      AssignmentCategory.create!(:name => 'Quiz')
      AssignmentCategory.create!(:name => 'Test')
      AssignmentCategory.create!(:name => 'Project')

      math = SupportingSkillCategory.create!(:name => 'Math')
      science = SupportingSkillCategory.create!(:name => 'Science')
      art = SupportingSkillCategory.create!(:name => 'Art')
      handwriting = SupportingSkillCategory.create!(:name => 'Handwriting')
      
      SupportingSkill.create!(:supporting_skill_category => math, :description => 'student can add', :active => true)
      SupportingSkill.create!(:supporting_skill_category => math, :description => 'student can substract', :active => true)
      
      SupportingSkill.create!(:supporting_skill_category => science, :description => 'student can add', :active => true)
      SupportingSkill.create!(:supporting_skill_category => science, :description => 'student can substract', :active => true)
      
      SupportingSkill.create!(:supporting_skill_category => art, :description => 'student can fingerpaint', :active => true)
      SupportingSkill.create!(:supporting_skill_category => handwriting, :description => 'student can clearly write their name', :active => true)
            
      scale = GradingScale.create!(:name => 'Standard', :active => true, :simple_view => false)
      ScaleRange.create!(:grading_scale => scale, :description => 'Understanding of subject is excellent', :max_score => 100, :min_score => 90, :letter_grade => 'A')
      ScaleRange.create!(:grading_scale => scale, :description => 'Understanding of subject is very good', :max_score => 89, :min_score => 80, :letter_grade => 'B')
      ScaleRange.create!(:grading_scale => scale, :description => 'Understanding of subject is adequate', :max_score => 79, :min_score => 70, :letter_grade => 'C')
      ScaleRange.create!(:grading_scale => scale, :description => 'Understanding of subject is poor', :max_score => 69, :min_score => 60, :letter_grade => 'D')
      ScaleRange.create!(:grading_scale => scale, :description => 'Understanding of subject is inadequate', :max_score => 59, :min_score => 0, :letter_grade => 'F')
            
      year = SchoolYear.create!(:name => 'Current Year')
      first_semester = Term.create!(:school_year => year, :name => 'First Semester', :begin_date => Date.parse('2009-08-01'), :end_date => Date.parse('2009-12-21'), :active => true)
      second_semester = Term.create!(:school_year => year, :name => 'Second Semester', :begin_date => Date.parse('2010-01-10'), :end_date => Date.parse('2010-06-15'))
      
      course = Course.create!(:code => 'MTH/100', :name => 'Introduction to Math', :grading_scale_id => scale.id)
      teach = Teacher.create!(
          :site_id => site.id,
          :school_number => "T-#{Populator.value_in_range(1..99999999)}",
          :login => Faker::Internet.user_name,
          :first_name => Faker::Name.first_name,
          :last_name => Faker::Name.last_name,
          :email => Faker::Internet.email,
          :password => 'password',
          :password_confirmation => 'password',
          :password_salt => Authlogic::Random.hex_token
          )      
      CourseTerm.create!( :code => "#{course.code}-001", :course_id => course.id, :term_id => first_semester.id, :teacher_id => teach.id)
      CourseTerm.create!( :code => "#{course.code}-002" , :course_id => course.id, :term_id => second_semester.id, :teacher_id => teach.id)
      
      course = Course.create!(:code => '1STGRADE', :name => 'The First Grade', :grading_scale_id => scale.id)
      teach = Teacher.create!(
          :site_id => site.id,
          :school_number => "T-#{Populator.value_in_range(1..99999999)}",
          :login => Faker::Internet.user_name,
          :first_name => Faker::Name.first_name,
          :last_name => Faker::Name.last_name,
          :email => Faker::Internet.email,
          :password => 'password',
          :password_confirmation => 'password',
          :password_salt => Authlogic::Random.hex_token
          )           
      CourseTerm.create!( :code => "#{course.code}-001", :course_id => course.id, :term_id => first_semester.id, :teacher_id => teach.id)
      CourseTerm.create!( :code => "#{course.code}-002", :course_id => course.id, :term_id => second_semester.id, :teacher_id => teach.id)

      3.times do
        site = Site.create!(:name => Populator.words(1..3).titleize, :school_id => 1)
                
        20.times do
          Student.create!(
          :site_id => site.id,
          :school_number => "ST#{Populator.value_in_range(1..99999999)}",
          :login => Faker::Internet.user_name,
          :first_name => Faker::Name.first_name,
          :last_name => Faker::Name.last_name,
          :email => Faker::Internet.email,
          :class_of => Populator.value_in_range(2008..2018),
          :homeroom => '',
          :password => 'password',
          :password_confirmation => 'password',
          :password_salt => Authlogic::Random.hex_token
          )
          
        end
      end
    end
  

  end
end