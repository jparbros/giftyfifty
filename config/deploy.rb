set :application, "dev.giftyfifty.com:65000"
role :app, application
role :web, application
role :db,  application, :primary => true

set :user, "giftyuser"
set :deploy_to, "/home/giftyuser/giftyfifty"
set :deploy_via, :remote_cache
set :use_sudo, false

set :scm, :git
set :repository,  "git@github.com:giftyfifty/giftyfifty.git"
set :branch, "master"

namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
    invoke_command "cd #{deploy_to}"
    invoke_command "thin restart -C config/thin.yml"
  end
end
        require 'config/boot'
        require 'hoptoad_notifier/capistrano'
