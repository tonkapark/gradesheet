class Mailer < ActionMailer::Base
  
  def invitation(invite)
    from       DO_NOT_REPLY
    recipients invite.email
    subject    "Welcome to edu"
    body       :invite => invite
  end
  
end
