# Be sure to restart your server when you modify this file

# Uncomment below to force Rails into production mode when
# you don't control web/app server and can't set it the proper way
# ENV['RAILS_ENV'] ||= 'production'

# Specifies gem version of Rails to use when vendor/rails is not present
RAILS_GEM_VERSION = '2.3.5' unless defined? RAILS_GEM_VERSION

# Bootstrap the Rails environment, frameworks, and default configuration
require File.join(File.dirname(__FILE__), 'boot')

Rails::Initializer.run do |config|

  # Add additional load paths for your own custom dirs
  config.load_paths += %W( #{RAILS_ROOT}/lib/reports )
  
  config.gem 'clearance', 
    :lib     => 'clearance', 
    :source  => 'http://gemcutter.org', 
    :version => '0.8.4'
  
  config.gem 'will_paginate', 
    :version => '~> 2.3.11', 
    :lib => 'will_paginate',
    :source  => 'http://gemcutter.org'    
    
  config.gem 'formtastic', :source => 'http://gemcutter.org/'
  config.gem 'pacecar'
  
  config.time_zone = 'UTC'
  
  
  config.active_record.observers = :enrollment_observer, :assignment_observer
end

