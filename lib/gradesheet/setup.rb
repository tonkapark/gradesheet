module Gradesheet
  class Setup
    class << self
 
      def admin_user
        new.admin_user
      end 
      
      def load_sample_data
        new.load_sample_data
      end       

    end 

    
    # Loads the default data
    # Raises a RecordNotSaved exception if something goes wrong
    def admin_user          
      User.transaction do
        school = School.create!(:name => 'School Name')
        admin = Administrator.create!(
            :school_id => school.id,
            :code => "ADMIN",
            :firstname => 'Super',
            :lastname => 'User'
        )               
        # Administrator user
        User.create!(:email => 'admin@localhost.com',
                     :admin => true, 
                     :password => 'admin', 
                     :password_confirmation => 'admin',                      
                     :email_confirmed => true,
                     :person_id => admin.id)
      end
    end

    def load_sample_data
      
      [Assignment, AssignmentEvaluation, Course, AssignmentCategory, SupportingSkill, SupportingSkillCategory, ScaleRange, GradingScale, Term, SchoolYear, Person, Site, School, Enrollment, CourseTerm, User].each(&:delete_all)
      
      admin_user
      
      school = School.find(:first)
      #create sites/buildings/rooms
      3.times do
        site = Site.create!(:name => Populator.words(1..3).titleize, :school_id => school.id)
         2.times do
           building = Building.create!(:name => Populator.words(1..2).titleize, :site_id => site.id)
            10.times do
              Room.create!(:building_id => building.id, :name => Populator.words(1..3).titleize, :seats => Populator.value_in_range(10..35))
            end            
         end         
      end
      
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
      
      25.times do
        teach = Teacher.create!(
            :school_id => school.id,
            :code => "T-#{Populator.value_in_range(1..99999999)}",
            :firstname => Faker::Name.first_name,
            :lastname => Faker::Name.last_name,
            :primary_phone => Faker::PhoneNumber.phone_number,
            :email => Faker::Internet.email
        )           
        User.create!(
          :person_id => teach.id,
          :email => teach.email,
          :password => 'password',
          :password_confirmation => 'password'      
        )
      end

      create_user = true
      100.times do
        firstname = Faker::Name.first_name
        lastname = Faker::Name.last_name      
        fullname = "#{firstname} #{lastname}"
        
        st = Student.create!(
        :school_id => school.id,
        :code => "ST-#{lastname[0,1]}#{rand(9999999999)}#{rand(999)}",          
        :firstname => firstname,
        :lastname => lastname,
        :primary_phone => Faker::PhoneNumber.phone_number,
        :email => Faker::Internet.email (fullname)        
        )
        
        if create_user
          User.create!(
          :person_id => st.id,
          :email => st.email,
          :password => 'password',
          :password_confirmation => 'password'     
          )
        end
        create_user = create_user ? false : true
      end
        
      10.times do
        course = Course.create!(:code => "#{Populator.words(1)}/#{Populator.value_in_range(100..500)}", :name => Populator.words(1..4).titleize, :grading_scale_id => scale.id)      
        1.times do
          room = Room.find(:first, :order => rand())
          teacher = Teacher.find(:first, :order => rand())
          course_offering = CourseTerm.create!( :code => "#{course.code}-001", :course_id => course.id, :term_id => first_semester.id, :teacher_id => teacher.id, :seats => Populator.value_in_range(1..room.seats), :room => room) 
          2.times do
            Assignment.create!(:course_term_id => course_offering.id, :name => Populator.words(1..3).titleize, :assignment_category => AssignmentCategory.find(:first, :order => rand()), :possible_points => rand(100), :due_date => Date.today + rand(100))
          end

          course_offering2 = CourseTerm.create!( :code => "#{course.code}-001", :course_id => course.id, :term_id => second_semester.id, :teacher_id => teacher.id, :seats => Populator.value_in_range(1..room.seats), :room => room)                      
          2.times do
            Assignment.create!(:course_term_id => course_offering2.id, :name => Populator.words(1..3).titleize, :assignment_category => AssignmentCategory.find(:first, :order => rand()), :possible_points => rand(100), :due_date => Date.today + rand(200))
          end
          
          students = Student.find(:all, :limit => course_offering.seats, :order => rand())
          students.each do |student|
            Enrollment.create!(:course_term_id => course_offering.id, :student_id => student.id) 
            Enrollment.create!(:course_term_id => course_offering2.id, :student_id => student.id) 
          end           
        end        
      end 
      
    end
  

  end
end