source 'https://rubygems.org'

gem 'rails', '~> 5.2.1'

gem 'pg'
gem 'kaminari'
gem 'simple_form'
gem 'paper_trail'
gem 'validates_timeliness'
gem 'pg_search'

# Auth & Mailing Gems
gem 'devise'
gem 'cancancan'
gem 'role_model'
gem 'sidekiq'
# needed for sidekiq-web
gem 'sinatra', require: false

# Assets group
gem 'sass-rails'
gem 'coffee-rails'
gem 'uglifier'
gem 'jquery-rails'
gem 'jquery-ui-rails'
gem 'underscore-rails'
gem 'font-awesome-sass'
gem 'kaminari-bootstrap3'

# Helpers (at console)
gem 'interactive_editor'
gem 'awesome_print'

gem 'thin'

group :development, :test do
  gem 'byebug'
end

group :development do
  gem 'web-console', '~> 2.0'
  gem 'listen'

  # Deploy gems
  gem 'capistrano'
  gem 'capistrano-rails'
  gem 'capistrano-bundler'
  gem 'capistrano-chruby'
  gem 'capistrano-sidekiq'
end

group :test do
  gem 'capybara', require: false
  gem 'selenium-webdriver', require: false
  gem 'database_cleaner', require: false
  gem 'capybara-screenshot', require: false
  gem 'chromedriver-helper', require: false

  gem 'minitest-reporters'
  gem 'rails-controller-testing' # Mother of God

  gem 'fabrication'
  gem 'faker'
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
