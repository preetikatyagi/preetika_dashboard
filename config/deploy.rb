set :application, "genealizer"
set :domain,      'genealizer.com'
#set :repository,  "ssh://#{domain}/var/git/#{application}"
set :repository,  "git@github.com:preston/genealizer.git"
set :use_sudo,    false
set :deploy_to,   "/var/www/#{application}"
set :deploy_via, 'copy'
set :scm,         "git"
# set :scm_username,    "www-data"
set :user,      "www-data"

role :app, 'orthos01.tgen.org', 'orthos02.tgen.org'
role :web, 'orthos01.tgen.org', 'orthos02.tgen.org'
role :db,  'orthos01.tgen.org', 'orthos02.tgen.org', :primary => true

namespace :deploy do
  task :start, :roles => :app do
    run "touch #{current_release}/tmp/restart.txt"
  end

  task :stop, :roles => :app do
    # Do nothing.
  end

  desc "Restart Application"
  task :restart, :roles => :app do
    run "touch #{current_release}/tmp/restart.txt"
  end
end


namespace :config do
 
  desc "Add server-only shared directories."
  task :setup, :roles => [:app] do
    run "mkdir -p #{shared_path}/config"
    run "mkdir -p #{shared_path}/db"
  end
  after "deploy:setup", "config:setup"
  
  desc "Update server-only config files to new deployment directory."
  task :update, :roles => [:app] do
  	run "cp -Rfv #{shared_path}/config #{release_path}"
    run "cp -Rfv #{shared_path}/public/data #{release_path}/public/"
  end
  after "deploy:update_code", "config:update"
 
  # desc "Update shared server database symlink for new deployment."
  # task :database, :roles => [:app] do
  #   run "ln -s #{shared_path}/db/production.sqlite3 #{release_path}/db/production.sqlite3"
  # end
  # after "deploy:update_code", "config:update"

end

Dir[File.join(File.dirname(__FILE__), '..', 'vendor', 'gems', 'hoptoad_notifier-*')].each do |vendored_notifier|
  $: << File.join(vendored_notifier, 'lib')
end

require 'hoptoad_notifier/capistrano'

# For the collectiveidea delayed_job plugin...
after "deploy:stop",    "delayed_job:stop"
after "deploy:start",   "delayed_job:start"
after "deploy:restart", "delayed_job:restart"

# Horrible, horrible hack!
namespace :delayed_job do
  desc "Stop the delayed_job process"
  task :stop, :roles => :app do
    run "cd #{current_path}; RAILS_ENV=production script/delayed_job stop"
  end
 
  desc "Start the delayed_job process"
  task :start, :roles => :app do
    run "cd #{current_path}; RAILS_ENV=production script/delayed_job start -n 3"
  end
 
  desc "Restart the delayed_job process"
  task :restart, :roles => :app do
    stop
    wait_for_process_to_end('delayed_job')
    start
  end
end

def wait_for_process_to_end(process_name)
  run "COUNT=1; until [ $COUNT -eq 0 ]; do COUNT=`ps -ef | grep -v 'ps -ef' | grep -v 'grep' | grep -i '#{process_name}'|wc -l` ; echo 'waiting for #{process_name} to end' ; sleep 2 ; done"
end
