source 'http://ruby.taobao.org'

gem 'rails', '3.2.13'

group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'

  gem 'uglifier', '>= 1.0.3'
  gem 'therubyracer', :platforms => :ruby
end

gem 'jquery-rails'
gem 'slim'
gem 'thin'
gem "simple_form"
gem "font-awesome-rails"
gem "bootstrap_helper"
gem "pg"
gem 'easy_captcha'
gem 'devise'
gem 'cancan'

gemfile_local = File.join(File.dirname(__FILE__), 'Gemfile.local')

if File.readable?(gemfile_local)
  gem "zhiyi-bootstrap-rails", :require => "bootstrap-rails",:path =>"../zhiyi-bootstrap-rails"
else
  gem "zhiyi-bootstrap-rails", :require => "bootstrap-rails", :git => "git@github.com:zhiyisoft/bootstrap-rails.git", :ref => "HEAD"
end
gem 'apotomo'
