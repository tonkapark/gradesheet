require 'active_record'

namespace :gradesheet do
            
  desc "Create admin username and initial site placeholders"
  task :setup => :environment do
    require 'authlogic'                 
    Gradesheet::Setup.bootstrap 
  end
  
end