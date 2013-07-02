source 'http://ruby.taobao.org'

gem 'rails', '3.2.13'

group :assets do
  gem 'uglifier', '>= 1.0.3'
end

gem 'jquery-rails'
gem 'slim'
gem 'thin'
gem "simple_form"
gem "font-awesome-rails"
gem "bootstrap_helper"
gem "pg"

gemfile_local = File.join(File.dirname(__FILE__), 'Gemfile.local')

if File.readable?(gemfile_local)
  gem "zhiyi-bootstrap-rails", :require => "bootstrap-rails",:path =>"../zhiyi-bootstrap-rails"
else
  gem "zhiyi-bootstrap-rails", :require => "bootstrap-rails", :git => "git@github.com:zhiyisoft/bootstrap-rails.git", :ref => "HEAD"
end
gem 'jquery_mobile_rails'
