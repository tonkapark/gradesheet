Factory.define :site do |s|
  s.name      { Faker::Lorem.words(2) }
  s.school_id { rand(10) } 
end
