source 'http://ruby.taobao.org'

gem 'rails', '3.2.13'

group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'bootstrap-sass', '2.3.1.3'

  gem 'compass-rails'
  gem 'coffee-rails', '~> 3.2.1'

  gem 'therubyracer', :platforms => :ruby
  gem 'uglifier', '>= 1.0.3'
end

gem 'jquery-rails', '3.0.4'
gem 'slim-rails'

gem 'simple_form'
gem 'apotomo'
gem 'will_paginate-bootstrap'

gem 'bcrypt-ruby', '~> 3.0.0'
gem 'ancestry'
gem "squeel"
gem "hanzi_to_pinyin"
gem "state_machine"

gem "settingslogic"
gem "cancan"

gem "pg"
gem 'activerecord-postgres-hstore'

group :development, :test do
  gem "zeus"
  gem 'pry-debugger'

  gem 'rspec-rails'
  gem 'factory_girl_rails'
end

group :test do
  gem 'cucumber-rails', :require => false
  gem 'capybara'
  gem 'database_cleaner'
end

group :production do
  gem "unicorn"
end