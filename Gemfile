source 'https://rubygems.org'

gem 'rails', '4.2.3'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'jquery-rails'
gem 'jbuilder', '~> 2.0'
gem 'sdoc', '~> 0.4.0', group: :doc

gem 'ancestry'
gem 'bcrypt', '~> 3.1.7'
gem 'backbone-on-rails'
gem 'curb'
gem 'd3-rails'

# TODO don't use WEBrick
# Use Unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

group :development do
  gem 'guard'
  gem 'guard-minitest'
  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'
end

group :test do
  gem 'capybara'
  gem 'capybara-webkit'
  gem 'minitest-reporters'
  gem 'selenium-webdriver'
  gem 'simplecov'
end

group :development, :test do
  platform :ruby do
    gem 'byebug'
    gem 'better_errors'
    gem 'binding_of_caller'
    gem 'faker'
    gem 'pry-rails'
    gem 'spring'
  end
end

platform :jruby do
  # Use jdbcsqlite3 as the database for Active Record
  gem 'activerecord-jdbcsqlite3-adapter'
  # See https://github.com/rails/execjs#readme for more supported runtimes
  gem 'therubyrhino'
end

platform :ruby do
  gem 'sqlite3'
  # TODO sort out therubyracer problems
  gem 'therubyracer', '0.12.1'
  # gem 'libv8', '3.16.14.7'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
