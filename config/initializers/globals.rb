GENERATIONS_LIST = %w(Jr Sr II III IV V VI VII VIII IX X)

SITE_NAME = "edu by Tonka Park"
SITE_DOMAIN = "edu.tonkapark.com"
SITE = RAILS_ENV == 'production' ? SITE_DOMAIN : 'localhost:3000'

#clearance variables
DO_NOT_REPLY = "donotreply@#{SITE_DOMAIN}"
HOST = RAILS_ENV == 'production' ? SITE_DOMAIN : 'localhost:3000'