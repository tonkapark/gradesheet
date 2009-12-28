module Gradesheet
  class Setup
    class << self
 
      def bootstrap
        new.bootstrap
      end 

    end 

    
    # Loads the default data
    # Raises a RecordNotSaved exception if something goes wrong
    def bootstrap
          
      StaticData.transaction do
        # Static Data
        StaticData.create!(:name => 'SITE_NAME', :value => 'School Name')
        StaticData.create!(:name => 'TAG_LINE', :value => 'The Best School Ever!')

        # Site Data
        site = Site.create!(:name => 'Main Campus', :school_id => 1)

        # Administrator user
        Administrator.create!(:login => 'admin', :first_name => 'Admin', :last_name => 'Admin',
                     :site => site, :is_admin => true, :password_salt => Authlogic::Random.hex_token,
                     :password => 'admin', :password_confirmation => 'admin', :email => 'admin@example.com')
      end
    end



  end
end