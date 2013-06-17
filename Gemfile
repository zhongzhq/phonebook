source "http://ruby.taobao.org"

ruby '1.9.3'
gem 'rails', '~> 3.2.11'

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
gem 'sqlite3'
gem "slim"
gem 'thin'
gem "rubycas-client"
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

gem "ruote"
gem "ruote-mon"
gem "simple_form"

gemfile_local = File.join(File.dirname(__FILE__), 'Gemfile.local')

if File.readable?(gemfile_local)
  gem "zhiyi-bootstrap-rails", :require => "bootstrap-rails",:path =>"../zhiyi-bootstrap-rails"

else
  gem "zhiyi-bootstrap-rails", :require => "bootstrap-rails", :git => "git@github.com:zhiyisoft/bootstrap-rails.git", :ref => "HEAD"

end
gem "font-awesome-rails"
