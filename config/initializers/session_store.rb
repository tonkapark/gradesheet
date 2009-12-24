# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_gradesheet_session',
  :secret      => 'd4acb457faed6a2d02beb47c2ac60be9b9572a8ed39628eedf18507ee793b5eed9f288fe9ec73d5055cd3fc3fc611f1aeed02e2b4635e79e141c057c567b2d68'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
