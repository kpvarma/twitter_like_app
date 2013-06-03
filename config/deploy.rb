require 'bundler/capistrano'
require 'capistrano_colors'
require 'capistrano-deploytags'
require 'capistrano/ext/multistage'

# Required for delayed_jobs
# require "delayed/recipes" 

# For easy crontab updated with deploys
# require "whenever/capistrano"

# Capistrano Integration with Whenever
# Command to use bundler
# set :whenever_command, "bundle exec whenever"

# To use different environments 
# set :whenever_environment, defer { stage }

# To namespace cron jobs of this application, not to overlap/overridden by other apps cron jobs
# set :whenever_identifier, defer { "#{application}_#{stage}" }

set :rvm_ruby_string, 'ruby-1.9.3-p429@twitter_like_app'
set :rvm_path, "$HOME/.rvm"
set :rvm_bin_path, "$HOME/.rvm/bin"
set :rvm_type, :system

set :stages, ["staging", "demo"]
set :default_stage, "staging"

set :use_sudo, false
set :keep_releases, 10
set :git_enable_submodules, 1

set :scm, 'git'
set :user, 'deploy'
set :repository, 'git@github.com:kpvarma/twitter_like_app.git'
set :base_path, '/u01/apps/qwinix/www'
set :normalize_asset_timestamps, false

set :app_name, 'twitter_like_app'
set :application, 'twitter_like_app.qwinixtech.com'
set :shared_children, shared_children + %w{public/uploads}

# http://stackoverflow.com/questions/7863070/capistrano-deploy-host-key-verification-failed
ssh_options[:forward_agent] = true
default_run_options[:pty] = true

before "deploy:restart", "deploy:copy_database_yml"
after 'deploy', 'deploy:migrate'
after 'deploy', 'deploy:cleanup'

# after 'deploy', 'cron:update' # To Update cronjob after deploying the code
# after 'deploy', 'delayed_job:restart' # To Restart delayed_job after deploying the code

## Necessary only to drop,create and reseed database. Not necessary other wise
# after 'deploy:update_code', 'deploy:kill_postgres_connections'

namespace :deploy do
  desc 'Tell Passenger to restart the app.'
  task :restart do
    run "touch #{current_path}/tmp/restart.txt"
  end

  desc "Symlink shared configs and folders on each release."
  task :copy_database_yml do
    #run "mkdir -p #{shared_path}/config"
    #run "cp -f #{release_path}/config/database.yml.example #{shared_path}/config/database.yml"
    run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
    run "rm -f #{release_path}/config/database.yml.example "
    run "rm -f #{release_path}/config/database.mysql.yml"
    run "rm -f #{release_path}/config/database.postgresql.yml"
    run "rm -f #{release_path}/config/database.sqlite.yml"
  end

  # To reset database connection, while deploying
  # desc 'kill pgsql users so database can be dropped'
  # task :kill_postgres_connections do
  #   run 'echo "SELECT pg_terminate_backend(procpid) FROM pg_stat_activity WHERE datname=\'twitter_like_app_staging\';" | psql -U postgres'
  # end
  
end

#namespace :cron do
#  desc 'Update cron job'
#  task :update do
#    run "cd #{release_path} && bundle exec whenever -i #{application}_#{stage} --update-crontab --set 'environment=#{stage}'"
#  end
#end

#namespace :delayed_job do 
#  desc "Restart the delayed_job process"
#  task :restart, :roles => :app do
#    run "cd #{current_path}; RAILS_ENV=#{stage} script/delayed_job restart"
#  end
#end
