# Load the Rails application.
require_relative 'application'

# Initialize the Rails application.
Rails.application.initialize!

config.action_mailer.smtp_settings = {
   user_name:            'suresh@luxire.com',
   password:             'sureshmca@1986',
   domain:               'luxire.com',
   address:              'smtp.gmail.com',
   port:                 587,      
   authentication:       'plain',
   enable_starttls_auto: true  
}
