source 'http://rubygems.org'

gem 'rails', '3.2.8'
gem 'pg'

#authentication
gem 'omniauth-twitter'
gem 'unicorn'
gem 'capistrano'
gem 'RedCloth'

# resque background queues
gem 'resque'
gem 'resque_mailer'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'therubyracer', :platforms => :ruby
  gem 'uglifier', '>= 1.0.3'
end

gem 'unicorn'
gem 'jquery-rails'

group :development do
  gem 'rvm-capistrano'
  gem 'capistrano-shared_file', require: nil
  gem 'capistrano-resque'
end

group :test do
  # Pretty printed test output
  gem 'turn', '~> 0.8.3', :require => false
end
