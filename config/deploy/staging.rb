server '68.168.252.184', :app, :web, :db, :primary => true

# RVM Settings
require 'rvm/capistrano'
set :rvm_ruby_string, 'ruby-1.9.3-p429@twitter_like_app'
# Add RVM's lib directory to the load path.
$:.unshift(File.expand_path('./lib', ENV['rvm_path']))
set :rvm_path, '/usr/local/rvm'
set :rvm_type, :system # Don't use system-wide RVM

set :deploy_via, :remote_cache
set :app_name, 'twitter_like_app'
set :application, 'twitter_like_app.qwinixtech.com'

set :deploy_to, "#{base_path}/#{app_name}"

set :branch, 'master'
set :port, 1422

set :rails_env, 'staging'
set :deploy_env, 'staging'


