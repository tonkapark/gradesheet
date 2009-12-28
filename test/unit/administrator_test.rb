require 'test_helper'

class AdministratorTest < ActiveSupport::TestCase

  context "working with administrator" do
    setup do
      @site = Factory(:site)
      5.times { Factory(:administrator, :site => @site) }
    end
      
    should_validate_uniqueness_of :login, :case_sensitive => false
    should_validate_presence_of :first_name
    should_validate_presence_of :last_name
    should_allow_values_for :email, "a@b.com", "asdf@asdf.com"
  end
end
