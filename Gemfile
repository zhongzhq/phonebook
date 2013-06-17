source 'https://rubygems.org'

gem 'rails', '3.2.13'

gem 'sqlite3'


group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'uglifier', '>= 1.0.3'
end

gem 'jquery-rails'

gemfile_local = File.join(File.dirname(__FILE__), 'Gemfile.local')

if File.readable?(gemfile_local)
  gem "zhiyi-bootstrap-rails", :require => "bootstrap-rails",:path =>"../zhiyi-bootstrap-rails"

else
  gem "zhiyi-bootstrap-rails", :require => "bootstrap-rails", :git => "git@github.com:zhiyisoft/bootstrap-rails.git", :ref => "HEAD"

end
gem "font-awesome-rails"
