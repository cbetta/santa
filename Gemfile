source 'http://rubygems.org'

gem 'rails', '3.2.11'
gem 'pg'

#authentication
gem 'omniauth-twitter'
gem 'unicorn'
gem 'capistrano'
gem 'RedCloth'

# resque background queues
gem 'resque', '1.23.0'
gem 'resque-pool', '0.3.0'
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
  gem 'rvm-capistrano', '1.2.7'
  gem 'capistrano-shared_file', github: "cbetta/capistrano-shared_file", branch: "load_fix"
  gem 'meta_request'
end

group :test do
  # Pretty printed test output
  gem 'turn', '~> 0.8.3', :require => false
end
