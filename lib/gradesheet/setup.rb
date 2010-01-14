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
      
      [Assignment, AssignmentEvaluation, Course, AssignmentCategory, ScaleRange, GradingScale, Catalog, CatalogTerm, Person, Site, Building, Room, School, Enrollment, CourseTerm, User].each(&:delete_all)
      
      admin_user
      
      school = School.find(:first)
      #create sites/buildings/rooms
      3.times do
        site = school.sites.create!(:name => Populator.words(1..3).titleize)
         2.times do
           building = school.buildings.create!(:site_id => site.id, :name => Populator.words(1..2).titleize)
            5.times do
              building.rooms.create!(:name => Populator.words(1..3).titleize, :seats => Populator.value_in_range(10..35))
            end            
         end         
      end
      
      school.assignment_categories.create!(:name => 'Homework')
      school.assignment_categories.create!(:name => 'Quiz')
      school.assignment_categories.create!(:name => 'Test')
      school.assignment_categories.create!(:name => 'Project')
            
      scale = school.grading_scales.create!(:name => 'Standard', :active => true, :simple_view => false)
      scale.scale_ranges.create!(:description => 'Understanding of subject is excellent', :max_score => 100, :min_score => 90, :letter_grade => 'A')
      scale.scale_ranges.create!(:description => 'Understanding of subject is very good', :max_score => 89, :min_score => 80, :letter_grade => 'B')
      scale.scale_ranges.create!(:description => 'Understanding of subject is adequate', :max_score => 79, :min_score => 70, :letter_grade => 'C')
      scale.scale_ranges.create!(:description => 'Understanding of subject is poor', :max_score => 69, :min_score => 60, :letter_grade => 'D')
      scale.scale_ranges.create!(:description => 'Understanding of subject is inadequate', :max_score => 59, :min_score => 0, :letter_grade => 'F')
            
      year = school.catalogs.create!(:name => 'Current Year')
      first_semester = year.catalog_terms.create!(:name => 'First Semester', :starts_on => Date.parse('2009-08-01'), :ends_on => Date.parse('2009-12-21'))
      second_semester = year.catalog_terms.create!(:name => 'Second Semester', :starts_on => Date.parse('2010-01-10'), :ends_on => Date.parse('2010-06-15'))
      
      10.times do
        
        firstname = Faker::Name.first_name
        lastname = Faker::Name.last_name      

        person = school.teachers.create!(
          :code => "T-#{Populator.value_in_range(1..99999999)}",
          :firstname => firstname,
          :lastname => lastname,
          :email => Faker::Internet.email("#{firstname} #{lastname}")
        )
        
        school.users.create!(
            :person => person,
            :email => person.email,
           :password => 'password', 
           :password_confirmation => 'password'
           )
      end

      create_user = true
      50.times do
        firstname = Faker::Name.first_name
        lastname = Faker::Name.last_name      

        person = school.students.create!(
          :code => "ST-#{Populator.value_in_range(1..99999999)}",
          :firstname => firstname,
          :lastname => lastname,
          :email => Faker::Internet.email("#{firstname} #{lastname}")
        )
        
        if create_user
          school.users.create!(
                        :person => person,
                        :email => person.email,
                       :password => 'password', 
                       :password_confirmation => 'password'
                       )
        end
        create_user = create_user ? false : true
      end
        
      2.times do
        course = school.courses.create!(:code => "#{Populator.words(1)}/#{Populator.value_in_range(100..500)}", :name => Populator.words(1..4).titleize)      
        1.times do
          room = school.rooms.find(:first, :offset => rand(3))
          teacher = school.teachers.find(:first, :offset => rand(3))
          course_offering = school.course_terms.create!(:code => "#{course.code}-001", :course_id => course.id, :catalog_id => year.id, :teacher_id => teacher.id, :seats => Populator.value_in_range(1..room.seats), :room_id => room.id, :grading_scale_id => scale.id) 
          2.times do
            school.assignments.create!(:course_term_id => course_offering.id, :name => Populator.words(1..3).titleize, :assignment_category => school.assignment_categories.find(:first, :offset => rand(3)), :possible_points => rand(100), :due_date => Date.today + rand(100))
          end

          course_offering2 = school.course_terms.create!(:code => "#{course.code}-002", :course_id => course.id, :catalog_id => year.id, :teacher_id => teacher.id, :seats => Populator.value_in_range(1..room.seats), :room_id => room.id, :grading_scale_id => scale.id)   
          2.times do
            school.assignments.create!(:course_term_id => course_offering2.id, :name => Populator.words(1..3).titleize, :assignment_category => school.assignment_categories.find(:first, :offset => rand(3)), :possible_points => rand(100), :due_date => Date.today + rand(200))
          end
          
          students = school.students.find(:all, :limit => course_offering.seats, :order => rand(), :offset => rand(course_offering.seats))
          students.each do |student|
            course_offering.enrollments.create!(:student_id => student.id) 
            course_offering2.enrollments.create!(:student_id => student.id) 
          end           
        end        
      end 
      
    end
  

  end
end
