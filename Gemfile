LANG="en_US.UTF-8"
LC_ALL="en_US.UTF-8"

source 'https://rubygems.org'
gem 'rails', '3.2.13'
gem 'rake', '0.9.6'

group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'uglifier', '>= 1.0.3'
  gem "twitter-bootstrap-rails"
end
gem 'jquery-rails'
gem 'jquery_datepicker'
gem "rspec-rails", ">= 2.12.2", :group => [:development, :test]
gem "database_cleaner", ">= 1.0.0.RC1", :group => :test
gem "email_spec", ">= 1.4.0", :group => :test
gem "cucumber-rails", ">= 1.3.1", :group => :test, :require => false
gem "launchy", ">= 2.2.0", :group => :test
gem "capybara", ">= 2.0.3", :group => :test
gem "factory_girl_rails", ">= 4.2.0", :group => [:development, :test]
gem "bootstrap-sass", ">= 2.3.0.0"
gem "devise", ">= 2.2.3"
gem "cancan", ">= 1.6.9"
gem "rolify", ">= 3.2.0"
gem "simple_form", ">= 2.1.0"
gem "quiet_assets", ">= 1.0.2", :group => :development
gem "figaro", ">= 0.6.3"
gem "better_errors", ">= 0.7.2", :group => :development
# Gema que nadie sape que es. Además tiene una versión muy antigua.
# gem "binding_of_caller", ">= 0.7.1", :group => :development, :platforms => [:mri_19, :rbx]
gem 'chosen-rails'
gem 'zipruby'
gem 'nokogiri'
gem 'libxml-ruby'
gem 'validates_timeliness', '~> 3.0'

# Gem for Chart printing
gem 'lazy_high_charts', '~> 1.4.0'
gem 'binding_of_caller', :group => :development, :platforms => [:mri_19, :rbx]


group :development, :test do
  gem 'sqlite3'
end
group :production do
  gem 'pg'
end

