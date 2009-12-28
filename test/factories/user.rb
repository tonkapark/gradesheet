Factory.define :user do |u|  
  u.login                 { Faker::Internet.user_name }
  u.first_name      { Faker::Name.first_name }
  u.last_name     { Faker::Name.last_name }
  u.password              { "password" }
  u.password_confirmation { "password" }
  u.site  { |site| site.association(:site) }
end

Factory.define :administrator, :parent => :user do |u|
  u.class {'Administrator'}
end

Factory.define :sysadmin, :parent => :administrator do |u|
  u.is_admin {true}
end

Factory.define :student, :parent => :user do |u|
  u.class { 'Student' }
end

Factory.define :teacher, :parent => :user do |u|
  u.class { 'Teacher' }
end

Factory.define :teacher_assistant, :parent => :user do |u|
  u.class { 'TeacherAssistant' }
end