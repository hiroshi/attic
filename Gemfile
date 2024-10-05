source "https://rubygems.org"

gem "rails", "~> 7.2.1"
gem "sprockets-rails"
gem "puma", ">= 5.0"
gem "jbuilder"
gem "tzinfo-data", platforms: %i[ windows jruby ]
gem "bootsnap", require: false

group :development, :test do
  gem "debug", platforms: %i[ mri windows ], require: "debug/prelude"
  gem "brakeman", require: false
  gem "rubocop-rails-omakase", require: false
  gem "rspec-rails", "~> 7.0"
end

group :development do
  gem "web-console"
end

# NOTE: once 9.0.2 is released use it instead of edge.
gem "mongoid", github: 'mongodb/mongoid', branch: 'master'
# warning: /usr/local/lib/ruby/3.3.0/ostruct.rb was loaded from the standard library, but will no longer be part of the default gems starting from Ruby 3.5.0.
gem 'ostruct'

gem "omniauth-google-oauth2", "~> 1.2"
gem "omniauth-rails_csrf_protection", "~> 1.0"
gem 'rack-cors'
