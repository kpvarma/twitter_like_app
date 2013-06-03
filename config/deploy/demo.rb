server '68.168.252.186', :app, :web, :db, :primary => true
set :base_path, '/u01/apps/mquiq/www'

# RVM Settings
require 'rvm/capistrano'
set :rvm_ruby_string, 'ruby-1.9.3-p0@mquiq'
# Add RVM's lib directory to the load path.
$:.unshift(File.expand_path('./lib', ENV['rvm_path']))

set :deploy_via, :remote_cache
set :rvm_path, "$HOME/.rvm"
set :rvm_type, :system # Don't use system-wide RVM

set :app_name, 'mquiq'
set :application, '68.168.252.186'
#set :application, 'mquiq.6kites.com'

set :deploy_to, "#{base_path}/#{app_name}"

set :branch, 'demo'
set :port, 1322

set :rails_env, 'demo'
set :deploy_env, 'demo'

set :rvm_bin_path, "$HOME/.rvm/bin"

