require 'active_record'

namespace :gradesheet do
            
  desc "Create admin username and initial site placeholders"
  task :admin => :environment do
    require 'authlogic'                 
    Gradesheet::Setup.admin_user 
  end
  
  desc "load sample data"
  task :sample => :environment do
    require 'authlogic'   
    require 'faker'
    require 'populator'
    
    Gradesheet::Setup.load_sample_data
    
  end
    
end