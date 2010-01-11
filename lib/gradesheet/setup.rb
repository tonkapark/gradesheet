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
        
        person = Administrator.create!(
          :school => school,
          :code => "ADMIN",
          :firstname => 'Super',
          :lastname => 'User'        
        )
          
        # Administrator user
        user = User.create!(
                      :school => school,
                      :person => person,
                      :email => 'admin@localhost.com',
                     :admin => true, 
                     :password => 'admin', 
                     :password_confirmation => 'admin'
                     )
                     
        
        user.confirm_email!
        user.save
      end
    end

    def load_sample_data
      
      [Assignment, AssignmentEvaluation, Course, AssignmentCategory, SupportingSkill, SupportingSkillCategory, ScaleRange, GradingScale, Term, SchoolYear, Person, Site, Building, Room, School, Enrollment, CourseTerm, User].each(&:delete_all)
      
      admin_user
      
      school = School.find(:first)
      #create sites/buildings/rooms
      3.times do
        site = Site.create!(:name => Populator.words(1..3).titleize, :school_id => school.id)
         2.times do
           building = Building.create!(:school => school, :name => Populator.words(1..2).titleize, :site_id => site.id)
            10.times do
              Room.create!(:school => school, :building_id => building.id, :name => Populator.words(1..3).titleize, :seats => Populator.value_in_range(10..35))
            end            
         end         
      end
      
      AssignmentCategory.create!(:school => school, :name => 'Homework')
      AssignmentCategory.create!(:school => school, :name => 'Quiz')
      AssignmentCategory.create!(:school => school, :name => 'Test')
      AssignmentCategory.create!(:school => school, :name => 'Project')

      math = SupportingSkillCategory.create!(:school => school, :name => 'Math')
      science = SupportingSkillCategory.create!(:school => school, :name => 'Science')
      art = SupportingSkillCategory.create!(:school => school, :name => 'Art')
      handwriting = SupportingSkillCategory.create!(:school => school, :name => 'Handwriting')
      
      SupportingSkill.create!(:school => school, :supporting_skill_category => math, :description => 'student can add', :active => true)
      SupportingSkill.create!(:school => school, :supporting_skill_category => math, :description => 'student can substract', :active => true)
      
      SupportingSkill.create!(:school => school, :supporting_skill_category => science, :description => 'student can add', :active => true)
      SupportingSkill.create!(:school => school, :supporting_skill_category => science, :description => 'student can substract', :active => true)
      
      SupportingSkill.create!(:school => school, :supporting_skill_category => art, :description => 'student can fingerpaint', :active => true)
      SupportingSkill.create!(:school => school, :supporting_skill_category => handwriting, :description => 'student can clearly write their name', :active => true)
            
      scale = GradingScale.create!(:school => school, :name => 'Standard', :active => true, :simple_view => false)
      ScaleRange.create!(:school => school, :grading_scale => scale, :description => 'Understanding of subject is excellent', :max_score => 100, :min_score => 90, :letter_grade => 'A')
      ScaleRange.create!(:school => school, :grading_scale => scale, :description => 'Understanding of subject is very good', :max_score => 89, :min_score => 80, :letter_grade => 'B')
      ScaleRange.create!(:school => school, :grading_scale => scale, :description => 'Understanding of subject is adequate', :max_score => 79, :min_score => 70, :letter_grade => 'C')
      ScaleRange.create!(:school => school, :grading_scale => scale, :description => 'Understanding of subject is poor', :max_score => 69, :min_score => 60, :letter_grade => 'D')
      ScaleRange.create!(:school => school, :grading_scale => scale, :description => 'Understanding of subject is inadequate', :max_score => 59, :min_score => 0, :letter_grade => 'F')
            
      year = SchoolYear.create!(:school => school, :name => 'Current Year')
      first_semester = Term.create!(:school => school, :school_year => year, :name => 'First Semester', :begin_date => Date.parse('2009-08-01'), :end_date => Date.parse('2009-12-21'), :active => true)
      second_semester = Term.create!(:school => school, :school_year => year, :name => 'Second Semester', :begin_date => Date.parse('2010-01-10'), :end_date => Date.parse('2010-06-15'))
      
      25.times do
        
        firstname = Faker::Name.first_name
        lastname = Faker::Name.last_name      

        person = Teacher.create!(
          :school => school,
          :code => "T-#{Populator.value_in_range(1..99999999)}",
          :firstname => firstname,
          :lastname => lastname,
          :email => Faker::Internet.email("#{firstname} #{lastname}")
        )
        
        User.create!(
            :school => school,
            :person => person,
            :email => person.email,
           :password => 'password', 
           :password_confirmation => 'password'
           )
      end

      create_user = true
      100.times do
        firstname = Faker::Name.first_name
        lastname = Faker::Name.last_name      

        person = Student.create!(
          :school => school,
          :code => "ST-#{Populator.value_in_range(1..99999999)}",
          :firstname => firstname,
          :lastname => lastname,
          :email => Faker::Internet.email("#{firstname} #{lastname}")
        )
        
        if create_user
          User.create!(
                        :school => school,
                        :person => person,
                        :email => person.email,
                       :password => 'password', 
                       :password_confirmation => 'password'
                       )
        end
        create_user = create_user ? false : true
      end
        
      10.times do
        course = Course.create!(:school => school, :code => "#{Populator.words(1)}/#{Populator.value_in_range(100..500)}", :name => Populator.words(1..4).titleize, :grading_scale_id => scale.id)      
        1.times do
          room = school.rooms.find(:first, :order => rand())
          teacher = school.teachers.find(:first, :order => rand())
          course_offering = CourseTerm.create!( :school => school, :code => "#{course.code}-001", :course_id => course.id, :term_id => first_semester.id, :teacher_id => teacher.id, :seats => Populator.value_in_range(1..room.seats), :room_id => room.id) 
          2.times do
            Assignment.create!(:school => school, :course_term_id => course_offering.id, :name => Populator.words(1..3).titleize, :assignment_category => AssignmentCategory.find(:first, :order => rand()), :possible_points => rand(100), :due_date => Date.today + rand(100))
          end

          course_offering2 = CourseTerm.create!(:school => school,  :code => "#{course.code}-001", :course_id => course.id, :term_id => second_semester.id, :teacher_id => teacher.id, :seats => Populator.value_in_range(1..room.seats), :room_id => room.id)   
          2.times do
            Assignment.create!(:school => school, :course_term_id => course_offering2.id, :name => Populator.words(1..3).titleize, :assignment_category => AssignmentCategory.find(:first, :order => rand()), :possible_points => rand(100), :due_date => Date.today + rand(200))
          end
          
          students = school.students.find(:all, :limit => course_offering.seats, :order => rand())
          students.each do |student|
            Enrollment.create!(:school => school, :course_term_id => course_offering.id, :student_id => student.id) 
            Enrollment.create!(:school => school, :course_term_id => course_offering2.id, :student_id => student.id) 
          end           
        end        
      end 
      
    end
  

  end
end