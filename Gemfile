source 'https://rubygems.org'

ruby '2.0.0'

gem 'rails', '~>4.0.0'
gem "figaro"
gem 'bourbon'
gem 'coffee-rails'
gem 'delayed_job_active_record', '>= 4.0.0.beta2'
gem 'email_validator'
gem 'flutie'
gem 'high_voltage'
gem 'jquery-rails'
gem 'neat'
gem 'pg'
gem 'rack-timeout'
gem 'recipient_interceptor'
gem 'sass-rails'
gem 'simple_form'
gem 'uglifier'
gem 'unicorn'
gem 'slim'
#lookup
gem "meta-spotify", "~> 0.3.1"
gem "lastfm", "~> 1.20.1"

gem 'byebug'
gem "omniauth-google-oauth2"

group :development do
  gem 'foreman'
  gem 'better_errors'
  gem 'quiet_assets'
  gem 'binding_of_caller'
  gem "capistrano"
  gem 'capistrano-unicorn', :require => false
end

group :development, :test do
  gem 'guard-rspec', '2.5.0'
  gem 'spork-rails', github: 'sporkrb/spork-rails'
  gem 'guard-spork', '1.5.0'
  gem 'childprocess', '0.3.6'

  gem 'factory_girl_rails'
  gem 'rspec-rails', '>= 2.14'
end

group :test do
  gem 'libnotify', '0.8.0'
  gem 'capybara-webkit', '>= 0.14.1'
  gem 'database_cleaner'
  gem 'launchy'
  gem 'shoulda-matchers'
  gem 'simplecov', require: false
  gem 'timecop'
  gem 'webmock'
end

group :staging, :production do
  gem 'newrelic_rpm', '>= 3.5.7'
  gem 'rails_12factor'
end
gem 'rvm-capistrano'
