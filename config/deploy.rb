$:.unshift(File.expand_path('./lib', ENV['rvm_path']))
require "rvm/capistrano"
set :rvm_ruby_string, '1.8.7@gifty'
set :rvm_type, :user

set :application, "dev.giftyfifty.com:65000"
role :app, application
role :web, application
role :db,  application, :primary => true

set :user, "giftyuser"
set :runner, "giftyuser"
set :deploy_to, "/home/giftyuser/giftyfifty"
set :deploy_via, :remote_cache
set :use_sudo, false

set :scm, :git
set :repository,  "git@github.com:giftyfifty/giftyfifty.git"
set :branch, "master"

namespace :deploy do
  task :start do
    find_and_execute_task("thin:start")
  end
  task :stop do 
    find_and_execute_task("thin:stop")
  end
  task :restart, :roles => :app, :except => { :no_release => true } do
    find_and_execute_task("thin:restart")
  end
end

namespace :config do |variable|
  task :database do
    run "ln -s #{deploy_to}/shared/config/database.yml #{deploy_to}/current/config/database.yml "
  end
  task :thins do
    run "ln -s #{deploy_to}/shared/config/thin.yml #{deploy_to}/current/config/thin.yml "
  end
end

namespace :thin do  
  %w(start stop restart).each do |action| 
  desc "#{action} the app's Thin Cluster"  
    task action.to_sym, :roles => :app do
      #run "cd #{deploy_to} && thin #{action} -c #{deploy_to}/current -p 3000 -e production -s 5 -P #{deploy_to}/current/tmp/pids/thin.pid -d" 
      #run "cd #{deploy_to} && thin #{action} -c #{deploy_to}/current -C #{deploy_to}/thin.yml" 
      run "thin #{action} -C #{deploy_to}/current/config/thin.yml"
    end
  end
end

after "deploy:symlink" do
  find_and_execute_task("config:database")
end

require 'config/boot'
require 'hoptoad_notifier/capistrano'