class Users::BaseController < ApplicationController
  before_filter :require_user
  append_before_filter :authorized?
  include SortHelper
  
end
