source 'http://ruby.taobao.org'

gem 'rails', '3.2.13'

group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'

  gem 'uglifier', '>= 1.0.3'
  gem 'therubyracer', :platforms => :ruby
end

gem 'jquery-rails'
gem 'slim-rails'

gem 'unicorn'

gem "simple_form"
gem 'client_side_validations'
gem 'client_side_validations-simple_form'

gem "font-awesome-rails"
gem "pg"
gem 'easy_captcha'
gem 'devise'
gem 'cancan'
gem 'ancestry'
gem 'validates_existence'
gem 'settingslogic'
gem 'state_machine'

gem 'will_paginate'
gem 'bootstrap-will_paginate'

gemfile_local = File.join(File.dirname(__FILE__), 'Gemfile.local')

if File.readable?(gemfile_local)
  gem "zhiyi-bootstrap-rails", :require => "bootstrap-rails",:path =>"../zhiyi-bootstrap-rails"
else
  gem "zhiyi-bootstrap-rails", :require => "bootstrap-rails", :git => "git@github.com:zhiyisoft/bootstrap-rails.git", :ref => "HEAD"
end
gem 'apotomo'

# Gems for test
group :development do
  gem 'rb-inotify', :require => false # Guard needs this
  gem 'libnotify', :require => false # Guard needs this
  gem 'zeus'
  gem 'guard-bundler'
  gem 'guard-livereload'
  gem 'guard-rspec'
  gem 'guard-cucumber'

  gem 'pry-rails'
end

group :test do
  gem 'cucumber-rails', :require => false
  gem 'capybara'
  gem 'database_cleaner'
end

group :development, :test do
  gem 'rspec-rails'
  gem 'factory_girl_rails'
end

# API
gem 'grape'
gem 'rack-contrib'
