# Contains the AuthLogic session information for each user.
class UserSession < Authlogic::Session::Base
  generalize_credentials_error_messages true  # don't give up any info about logins
  logout_on_timeout true                      # default is false
  consecutive_failed_logins_limit 10          # only let them try to log in 10 times
  failed_login_ban_for 30.minutes             # and keep them out for 30 minutes
end
