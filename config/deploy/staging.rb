server '68.168.252.184', :app, :web, :db, :primary => true

# RVM Settings
require 'rvm/capistrano'

# Add RVM's lib directory to the load path.
$:.unshift(File.expand_path('./lib', ENV['rvm_path']))

set :deploy_via, :remote_cache
set :app_name, 'twitter_like_app'
set :application, 'twitter_like_app.qwinixtech.com'

set :deploy_to, "#{base_path}/#{app_name}"

set :branch, 'master'
set :port, 1422

set :rails_env, 'staging'
set :deploy_env, 'staging'


