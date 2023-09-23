# frozen_string_literal: true

source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.2.2"

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem "rails", "~> 7.0.8"

gem "foreman"
gem "pg", "~> 1.1" # Use postgresql as the database for Active Record
gem "pg_search"
gem "puma", "~> 5.6" # Use the Puma web server [https://github.com/puma/puma]

# assets
gem "importmap-rails" # Use JavaScript with ESM import maps [https://github.com/rails/importmap-rails]
gem "propshaft" # The modern asset pipeline for Rails [https://github.com/rails/propshaft]
gem "slim-rails"
gem "stimulus-rails" # Hotwire's modest JavaScript framework [https://stimulus.hotwired.dev]
gem "tailwindcss-rails" # Use Tailwind CSS [https://github.com/rails/tailwindcss-rails]
gem "turbo-rails" # Hotwire"s SPA-like page accelerator [https://turbo.hotwired.dev]

# views
gem "simple_form" # Use simple_form to build forms
gem "simple_form_tailwind_css"
# Use view_component to manage components and markup
gem "view_component", "~> 2.80"
gem "view_component-contrib", "~> 0.1.1"

gem "administrate" # Use administrate to administrate users and charts
gem "bcrypt", "~> 3.1.7" # Use Active Model has_secure_password [https://guides.rubyonrails.org/active_model_basics.html#securepassword]
gem "devise" # Use Devise for authentication of users
gem "rack-attack" # User rack-attack to throttle requests
gem "tzinfo-data", platforms: %i[mingw mswin x64_mingw jruby] # Windows does not include zoneinfo files, so bundle the tzinfo-data gem

# Use Sass to process CSS
# gem "sassc-rails"

# Use Active Storage variants [https://guides.rubyonrails.org/active_storage_overview.html#transforming-images]
# gem "image_processing", "~> 1.2"

gem "kredis" # Use Kredis to get higher-level data types in Redis [https://github.com/rails/kredis]
gem "redis", "~> 4.0" # Use Redis adapter to run Action Cable in production
gem "redis-namespace"
gem "sidekiq"
gem "sidekiq-batch"

gem "sentry-rails"
gem "sentry-ruby"
gem "sentry-sidekiq"

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem "amazing_print"
  gem "debug", platforms: %i[mri mingw x64_mingw]

  gem "factory_bot_rails"
  gem "faker"
  gem "kamal"
  gem "mutant-rspec"
  gem "pry-remote"
  # gem "rails-controller-testing"
  gem "rspec-rails"
  gem "webrick" # required by capybara servers

  gem "rubocop", require: false
  gem "rubocop-performance", require: false
  gem "rubocop-rails", require: false
  gem "rubocop-rspec", require: false
  gem "slim_lint", require: false

  gem "rspec_junit_formatter"
end

group :development do
  gem "bullet"
  gem "dockerfile-rails"
  gem "letter_opener"
  gem "maily"
  gem "rack-mini-profiler" # Add speed badges [https://github.com/MiniProfiler/rack-mini-profiler]
  gem "web-console" # Use console on exceptions pages [https://github.com/rails/web-console]

  # Speed up commands on slow machines / big apps [https://github.com/rails/spring]
  # gem "spring"
end

group :test do
  # Use system testing [https://guides.rubyonrails.org/testing.html#system-testing]
  gem "capybara"
  gem "capybara_discoball"
  gem "cuprite"
  gem "database_cleaner"
  gem "launchy"
  gem "rspec-sidekiq"
  # gem "selenium-webdriver"
  gem "timecop"
  # gem "webdrivers"
  gem "webmock"
end
