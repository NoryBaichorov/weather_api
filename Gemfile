source "https://rubygems.org"

ruby "3.2.2"

# Main Framework
gem "rails", "~> 7.1.4"

# Database
gem "sqlite3", "~> 1.4"

# Rails Server
gem "puma", ">= 5.0"

gem "tzinfo-data", platforms: %i[ windows jruby ]

gem "bootsnap", require: false

# Supporting gems
gem 'delayed_job_active_record'
gem 'rufus-scheduler'
gem 'vcr'
gem 'httparty'

gem 'grape'
gem 'grape-swagger'
gem 'grape-swagger-rails'

group :development, :test do
  gem "debug", platforms: %i[ mri windows ]
  gem 'rspec-rails', '~> 6.1.0'
  gem 'webmock'
end

group :development do; end

