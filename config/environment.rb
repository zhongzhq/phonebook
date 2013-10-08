# Load the rails application
require File.expand_path('../application', __FILE__)

Paperclip.interpolates :username do |attachment, style|
  attachment.instance.username
end

# Initialize the rails application
Phonebook::Application.initialize!
