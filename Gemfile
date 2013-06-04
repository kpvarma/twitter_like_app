source 'https://rubygems.org'

gem 'rails', '3.2.13'

group :staging, :demo, :production do
  gem 'pg'
end

group :development, :test do
  gem 'sqlite3'
end

# Monitoring
gem 'newrelic_rpm'

#gem 'psych'
gem 'devise'
gem "simple_form"
gem("thin")

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  gem 'therubyracer'

  gem 'uglifier', '>= 1.0.3'
end

gem 'jquery-rails'

group :development, :test do
  
  ## Deployment Modules
  gem "capistrano"
  gem "capistrano-deepmodules"
  gem "capistrano_colors"
  gem "capistrano-ext"
  gem "capistrano-deploytags"
  gem "rvm-capistrano"
  
  ## Testing Modules
  gem "capybara"
  gem "database_cleaner"
  gem "launchy"
  gem "rspec-rails"
  gem "factory_girl_rails"
  gem "faker"
  
  ## Others
  gem "quiet_assets"
  gem "colorize"
  gem "pry"
  
end

group :test do
  gem "cucumber-rails"
end