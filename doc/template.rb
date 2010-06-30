# Template created by You've Got Rails (http://www.youvegotrails.com)


# Copy database.yml
run 'cp config/database.yml config/database.yml.example'


# Remove unnecessary Rails files
run 'rm README'
run 'rm public/index.html'
run 'rm public/favicon.ico'
run 'rm public/images/rails.png'

gem 'rubyist-aasm'
gem 'sqlite3-ruby', :lib => 'sqlite3'
gem 'mislav-will_paginate', :lib => 'will_paginate',  :source => 'http://gems.github.com'
plugin 'role_requirement', :git => 'git://github.com/timcharper/role_requirement.git'
plugin 'exception_notifier', :git => 'git://github.com/rails/exception_notification.git'
plugin 'paperclip', :git => 'git://github.com/thoughtbot/paperclip.git'
plugin 'restful-authentication', :git => 'git://github.com/technoweenie/restful-authentication.git'
# Install gems on local system
rake('gems:install', :sudo => true) if yes?('Install gems on local system? (y/n)')


# Use database (active record) session store
rake('db:sessions:create')
initializer 'session_store.rb', <<-FILE
  ActionController::Base.session = { :session_key => '_#{(1..6).map { |x| (65 + rand(26)).chr }.join}_session', :secret => '#{(1..40).map { |x| (65 + rand(26)).chr }.join}' }
  ActionController::Base.session_store = :active_record_store
FILE

# Unpack gems into vendor/gems
rake('gems:unpack:dependencies') if yes?('Unpack gems into vendor directory? (y/n)')

# Generate restful-authentication user and session
generate("authenticated", "user session")

# Generate roles for User
generate("roles", "Role User")


# Freeze Rails into vendor/rails
freeze!


# Install and configure capistrano
run "sudo gem install capistrano" if yes?('Install Capistrano on your local system? (y/n)')

capify!

file 'Capfile', <<-FILE
  load 'deploy' if respond_to?(:namespace) # cap2 differentiator
  Dir['vendor/plugins/*/recipes/*.rb'].each { |plugin| load(plugin) }
  load 'config/deploy'
FILE


# Create .gitignore file
file '.gitignore', <<-FILE
.DS_Store
log/*.log
tmp/**/*
config/database.yml
db/*.sqlite3
FILE

# Set up git repository
git :init
git :add => '.'

