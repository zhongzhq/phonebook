class API < Grape::API
#  before_filter :authenticate_user!, :except => [:login]

  mount Phonebook::Version
#  mount Phonebook::User

end
