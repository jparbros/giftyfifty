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
    invoke_command "cd #{deploy_to} && thin start -C config/thin.yml"
  end
  task :stop do 
    invoke_command "cd #{deploy_to} && thin stop -C config/thin.yml"
  end
  task :restart, :roles => :app, :except => { :no_release => true } do
    invoke_command "cd #{deploy_to} && thin restart -C config/thin.yml"
  end
end

require 'config/boot'
require 'hoptoad_notifier/capistrano'