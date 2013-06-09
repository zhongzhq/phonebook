source "http://ruby.taobao.org"
# source 'https://rubygems.org'

gem 'rails', '3.2.13'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'



# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  # gem 'therubyracer', :platforms => :ruby

  gem 'uglifier', '>= 1.0.3'
end
gem 'execjs'
gem 'therubyracer'
gem 'jquery-rails'

# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Use unicorn as the app server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'debugger'

gem "slim"
gem "rubycas-client"
gem "cancan"
gem "settingslogic"
gem "cells"
group :test do
  gem "turn", :require => false
  gem "rspec-rails"
  gem "spork"
  gem "database_cleaner"
  gem "factory_girl_rails", :require => false
  gem "capybara"
  gem "launchy"
  gem "guard-spork"
  gem "guard-rspec"
  gem "guard-livereload"
  gem "guard-bundler"
  gem "simplecov", :require => false
end
gemfile_local = File.join(File.dirname(__FILE__), 'Gemfile.local')

if File.readable?(gemfile_local)

  gem "zhiyi-bootstrap-rails", :require => "bootstrap-rails",:path =>"../zhiyi-bootstrap-rails"
  gem 'unirole', :path => "../zhiyi-unirole"

else

  gem 'unirole', :git => 'git@github.com:zhiyisoft/zhiyi-unirole.git', :branch => "dev"
  gem "zhiyi-bootstrap-rails", :require => "bootstrap-rails", :git => "git@github.com:zhiyisoft/bootstrap-rails.git", :ref => "HEAD"

end

gem "ruote"
gem "ruote-mon"
gem "mongoid"
gem "mongoid-ancestry"
gem "simple_form"
gem 'will_paginate_mongoid'

