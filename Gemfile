source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

gem 'capistrano', '~> 3.0'
gem 'capistrano-rvm'

ruby "3.2.2"

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem "rails", "~> 7.1.3.3"

# Use postgresql as the database for Active Record
gem "pg", "~> 1.1"
gem 'activerecord-postgresql-adapter'

# Use the Puma web server [https://github.com/puma/puma]
gem "puma", "~> 6.0"

gem 'sendgrid-ruby'

# Build JSON APIs with ease [https://github.com/rails/jbuilder]
# gem "jbuilder"
gem 'mail'
# Use Redis adapter to run Action Cable in production
# gem "redis", "~> 4.0"

# Use Kredis to get higher-level data types in Redis [https://github.com/rails/kredis]
# gem "kredis"

# Use Active Model has_secure_password [https://guides.rubyonrails.org/active_model_basics.html#securepassword]
# gem "bcrypt", "~> 3.1.7"

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: %i[ mingw mswin x64_mingw jruby ]

# Reduces boot times through caching; required in config/boot.rb
gem "bootsnap", require: false

# Use Active Storage variants [https://guides.rubyonrails.org/active_storage_overview.html#transforming-images]
gem "image_processing", "~> 1.2"

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible
gem "rack-cors"

gem 'devise'
gem 'devise-jwt'
gem 'jsonapi-serializer'

gem 'cancancan'
gem 'carrierwave'
gem 'mini_magick', '4.11.0'
gem 'wicked_pdf'
gem 'wkhtmltopdf-binary'
gem 'fastimage'
# gem 'will_paginate'
gem 'kaminari'
gem 'streamio-ffmpeg'

gem 'sidekiq'
gem 'whenever'

gem 'activeadmin'
gem 'sprockets-rails'
gem "sassc-rails"
gem 'country-select'
gem 'rest-client'


gem 'dotenv-rails', groups: [:development, :test]


group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem "debug", platforms: %i[ mri mingw x64_mingw ]
end

group :development do
  # Speed up commands on slow machines / big apps [https://github.com/rails/spring]
  # gem "spring"
end