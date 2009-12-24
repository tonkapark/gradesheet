namespace :db do 
  
  desc "Drop then recreate the non-production database, migrate up" 
  task :remigrate => :environment do
    return unless %w[development test staging].include? RAILS_ENV
    ActiveRecord::Base.connection.tables.each { |t| ActiveRecord::Base.connection.drop_table t }
    # Migrate upward 
    Rake::Task["db:migrate"].invoke      
    # Dump the schema
    Rake::Task["db:schema:dump"].invoke    
  end
  
end