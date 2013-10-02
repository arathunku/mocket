source 'https://rubygems.org'

ruby '2.0.0'

gem 'rails', '~>4.0.0'
gem "figaro", '~> 0.7.0'
gem 'bourbon'
gem 'coffee-rails', '~> 4.0.0'
gem 'delayed_job_active_record', '>= 4.0.0.beta2'
gem 'email_validator'
gem 'flutie', '~> 2.0.0'
gem 'high_voltage'
gem 'jquery-rails', '~> 3.0.4'
gem 'neat', '~> 1.3.0'
gem 'pg'
gem 'rack-timeout'
gem 'recipient_interceptor'
gem 'sass-rails'
gem 'simple_form'
gem 'uglifier'
gem 'unicorn'
gem 'slim', '~> 2.0.1'
#lookup
gem "meta-spotify", "~> 0.3.1"
gem "lastfm", "~> 1.20.1"
gem "youtube_it", "~> 2.3.2"

gem 'byebug'
gem "omniauth-google-oauth2", '~> 0.2.1'
gem 'will_paginate', '~> 3.0.5'

group :development do
  gem 'annotate'
  gem 'foreman', '~> 0.63.0'
  gem 'better_errors'
  gem 'quiet_assets'
  gem 'binding_of_caller'
  gem "capistrano", '~> 2.15.5'
  gem 'capistrano-unicorn', '~> 0.1.10', :require => false
  gem 'brakeman', :require => false
end

group :development, :test do
  gem 'guard-rspec', '2.5.0'
  gem 'spork-rails', github: 'sporkrb/spork-rails'
  gem 'guard-spork', '1.5.0'
  gem 'childprocess', '0.3.6'
  gem 'factory_girl_rails', '~> 4.2.1'
  gem 'rspec-rails', '>= 2.14'
end

group :test do
  gem 'rack_session_access'
  gem 'libnotify', '0.8.0'
  gem 'capybara-webkit', '>= 0.14.1'
  gem 'database_cleaner'
  gem 'launchy'
  gem 'shoulda-matchers', '~> 2.3.0'
  gem 'simplecov', require: false
  gem 'timecop'
  gem 'webmock'
end

group :staging, :production do
  gem 'newrelic_rpm', '>= 3.5.7'
  gem 'rails_12factor'
end

gem 'rvm-capistrano'
