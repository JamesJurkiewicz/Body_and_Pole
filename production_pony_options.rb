# Pony.options = {
#   :via => :smtp,
#   :via_options => {
#     :address => 'smtp.sendgrid.net',
#     :port => '587',
#     :domain => 'heroku.com',
#     :user_name => ENV['SENDGRID_USERNAME'],
#     :password => ENV['SENDGRID_PASSWORD'],
#     :authentication => :plain,
#     :enable_starttls_auto => true
#   }
# }

# Pony.options = {
#   :via => :smtp,
#   :via_options => {
#     :address => 'smtp.iomartmail.net',
#     :port => '587',
#     :domain => 'bridgeofsighsball.co.uk',
#     :user_name => 'tickets@bridgeofsighsball',
#     :password => 'bsob4',
#     :authentication => :plain,
#     :enable_starttls_auto => true
#   }
# }

# Gmail options
Pony.options = {
  :via => 'smtp',
  :via_options => {
    :address              => 'smtp.gmail.com',
    :port                 => '587',
    :enable_starttls_auto => true,
    :user_name            => 'james.jurkiewicz12',
    :password             => 'JboSelect1',
    :authentication       => :plain, # :plain, :login, :cram_md5, no auth by default
    :domain               => "localhost.localdomain" # the HELO domain provided by the client to the server
  }
}