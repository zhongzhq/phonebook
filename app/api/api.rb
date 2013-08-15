class API < Grape::API

  mount Phonebook::Versions
  mount Phonebook::Users
  mount Phonebook::Organs


  helpers do

  end

end
