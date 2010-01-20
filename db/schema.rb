# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20100113155923) do

  create_table "assignment_categories", :force => true do |t|
    t.integer  "school_id",  :null => false
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "assignment_categories", ["school_id"], :name => "index_assignment_categories_on_school_id"

  create_table "assignment_evaluations", :force => true do |t|
    t.integer  "school_id",     :null => false
    t.integer  "assignment_id", :null => false
    t.integer  "enrollment_id", :null => false
    t.integer  "student_id"
    t.string   "points_earned"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "assignment_evaluations", ["enrollment_id"], :name => "index_assignment_evaluations_on_enrollment_id"
  add_index "assignment_evaluations", ["school_id"], :name => "index_assignment_evaluations_on_school_id"
  add_index "assignment_evaluations", ["student_id", "assignment_id"], :name => "index_assignment_evaluations_on_student_id_and_assignment_id", :unique => true

  create_table "assignments", :force => true do |t|
    t.integer  "school_id",              :null => false
    t.integer  "course_term_id",         :null => false
    t.string   "name"
    t.integer  "assignment_category_id"
    t.float    "possible_points"
    t.datetime "due_date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "assignments", ["assignment_category_id"], :name => "index_assignments_on_assignment_category_id"
  add_index "assignments", ["course_term_id"], :name => "index_assignments_on_course_term_id"
  add_index "assignments", ["school_id"], :name => "index_assignments_on_school_id"

  create_table "buildings", :force => true do |t|
    t.integer  "school_id",                  :null => false
    t.integer  "site_id",                    :null => false
    t.string   "name"
    t.integer  "rooms_count", :default => 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "buildings", ["school_id"], :name => "index_buildings_on_school_id"
  add_index "buildings", ["site_id"], :name => "index_buildings_on_site_id"

  create_table "catalog_terms", :force => true do |t|
    t.integer  "catalog_id",                    :null => false
    t.string   "name"
    t.date     "starts_on"
    t.date     "ends_on"
    t.boolean  "locked",     :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "catalog_terms", ["catalog_id"], :name => "index_catalog_terms_on_catalog_id"
  add_index "catalog_terms", ["starts_on"], :name => "index_catalog_terms_on_starts_on"

  create_table "catalogs", :force => true do |t|
    t.integer  "school_id",                      :null => false
    t.string   "name"
    t.string   "description"
    t.boolean  "locked",      :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "catalogs", ["school_id"], :name => "index_catalogs_on_school_id"

  create_table "course_terms", :force => true do |t|
    t.integer  "school_id",                        :null => false
    t.integer  "catalog_id",                       :null => false
    t.integer  "course_id",                        :null => false
    t.string   "code"
    t.integer  "teacher_id"
    t.integer  "room_id"
    t.integer  "seats"
    t.integer  "grading_scale_id"
    t.integer  "enrollments_count", :default => 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "course_terms", ["catalog_id"], :name => "index_course_terms_on_catalog_id"
  add_index "course_terms", ["code"], :name => "index_course_terms_on_code"
  add_index "course_terms", ["course_id"], :name => "index_course_terms_on_course_id"
  add_index "course_terms", ["grading_scale_id"], :name => "index_course_terms_on_grading_scale_id"
  add_index "course_terms", ["room_id"], :name => "index_course_terms_on_room_id"
  add_index "course_terms", ["school_id", "code"], :name => "index_course_terms_on_school_id_and_code", :unique => true
  add_index "course_terms", ["school_id"], :name => "index_course_terms_on_school_id"

  create_table "courses", :force => true do |t|
    t.integer  "school_id",  :null => false
    t.string   "code"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "courses", ["school_id", "code"], :name => "index_courses_on_school_id_and_code", :unique => true
  add_index "courses", ["school_id"], :name => "index_courses_on_school_id"

  create_table "enrollments", :force => true do |t|
    t.integer  "student_id",                             :null => false
    t.integer  "course_term_id",                         :null => false
    t.integer  "course_id"
    t.string   "grade"
    t.datetime "graded_at"
    t.float    "total_points_earned", :default => 0.0
    t.boolean  "accommodation",       :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "enrollments", ["course_id"], :name => "index_enrollments_on_course_id"
  add_index "enrollments", ["course_term_id", "student_id"], :name => "index_enrollments_on_course_term_id_and_student_id", :unique => true
  add_index "enrollments", ["course_term_id"], :name => "index_enrollments_on_course_term_id"
  add_index "enrollments", ["student_id"], :name => "index_enrollments_on_student_id"

  create_table "grading_scales", :force => true do |t|
    t.integer  "school_id",                      :null => false
    t.string   "name"
    t.boolean  "active",      :default => true
    t.boolean  "simple_view", :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "grading_scales", ["school_id"], :name => "index_grading_scales_on_school_id"

  create_table "people", :force => true do |t|
    t.integer  "school_id",       :null => false
    t.string   "type",            :null => false
    t.string   "code"
    t.string   "firstname"
    t.string   "middlename"
    t.string   "lastname"
    t.string   "generation"
    t.string   "gender"
    t.date     "dob"
    t.string   "primary_phone"
    t.string   "secondary_phone"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "people", ["code"], :name => "index_people_on_code"
  add_index "people", ["lastname"], :name => "index_people_on_lastname"
  add_index "people", ["school_id"], :name => "index_people_on_school_id"

  create_table "posts", :force => true do |t|
    t.integer  "school_id"
    t.string   "title"
    t.text     "body"
    t.boolean  "active"
    t.datetime "published_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "rooms", :force => true do |t|
    t.integer  "building_id", :null => false
    t.string   "name"
    t.integer  "seats"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "rooms", ["building_id"], :name => "index_rooms_on_building_id"

  create_table "scale_ranges", :force => true do |t|
    t.integer  "grading_scale_id"
    t.string   "description"
    t.float    "max_score"
    t.float    "min_score"
    t.string   "letter_grade",     :null => false
    t.integer  "position"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "scale_ranges", ["grading_scale_id"], :name => "index_scale_ranges_on_grading_scale_id"

  create_table "schools", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sites", :force => true do |t|
    t.integer  "school_id",  :null => false
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sites", ["school_id"], :name => "index_sites_on_school_id"

  create_table "users", :force => true do |t|
    t.integer  "school_id",                                            :null => false
    t.string   "email"
    t.string   "encrypted_password", :limit => 128
    t.string   "salt",               :limit => 128
    t.string   "confirmation_token", :limit => 128
    t.string   "remember_token",     :limit => 128
    t.boolean  "email_confirmed",                   :default => false, :null => false
    t.boolean  "admin",                             :default => false, :null => false
    t.integer  "person_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], :name => "index_users_on_email"
  add_index "users", ["id", "confirmation_token"], :name => "index_users_on_id_and_confirmation_token"
  add_index "users", ["person_id"], :name => "index_users_on_person_id"
  add_index "users", ["remember_token"], :name => "index_users_on_remember_token"
  add_index "users", ["school_id"], :name => "index_users_on_school_id"

end
