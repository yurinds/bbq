source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.5.1'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.2.3'

gem 'jquery-rails', '~> 4.2'

gem "nokogiri", ">= 1.10.4"

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# загрузка и обработка картинок
gem 'carrierwave'
gem 'rmagick'
gem 'fog-aws'

# авторизация пользователей 
gem 'pundit'

# карусель 
gem 'owlcarousel-rails'

# Регистрация и авторизация на сайте
gem "devise", ">= 4.7.1"

# Локализация приложения
gem 'rails-i18n', '~> 5.1' 
gem 'devise-i18n'

# В продакшне (на хероку) мы используем БД postrgres, 
# поэтому нам нужен гем pg
group :production do
  gem 'pg'
end

# работа с фоновыми заданиями
gem 'delayed_job_active_record'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  # Use sqlite3 as the database for Active Record

  gem 'sqlite3'
  gem 'rspec-rails', '~> 3.8'
  gem 'factory_bot_rails'
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'

  gem 'capistrano', '~> 3.11'
  gem 'capistrano-rails', '~> 1.4'
  gem 'capistrano-passenger', '~> 0.2'
  gem 'capistrano-rbenv', '~> 2.1'
  gem 'capistrano-bundler', '~> 1.6'
end
