# Load the Rails application.
require_relative 'application'

# Initialize the Rails application.
Rails.application.initialize!

config.action_mailer.smtp_settings = {
   user_name:            '<username>',
   password:             '<password>',
   domain:               'example.com',
   address:              'smtp.gmail.com',
   port:                 587,      
   authentication:       'plain',
   enable_starttls_auto: true  
}
