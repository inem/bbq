source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.0.2"

gem "aws-sdk-s3"
gem "bootsnap", require: false
gem "cssbundling-rails"
gem "devise-i18n"
gem "devise"
gem "image_processing", ">= 1.2"
gem "jbuilder"
gem "jsbundling-rails"
gem "puma", "~> 5.0"
gem "rails-i18n"
gem "rails", "~> 7.0.3", ">= 7.0.3.1"
gem "sprockets-rails"
gem "stimulus-rails"
gem "turbo-rails"

group :development, :test do
  gem "debug", platforms: %i[ mri mingw x64_mingw ]
  gem "sqlite3", "~> 1.4"
end

group :production do
  gem "pg"
end

group :test do
  gem "capybara"
  gem "selenium-webdriver"
  gem "webdrivers"
end
