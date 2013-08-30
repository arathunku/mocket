require "rvm/capistrano"
require "bundler/capistrano"
require 'capistrano-unicorn'


set :user, :ubuntu
server "54.213.179.27", :app, :web, :db, :primary => true
set :ssh_options, { :forward_agent => true }

set :application, "mocket"
set :scm, :git
set :repository, "git@github.com:arathunku/mocket.git"
set :branch, "master"
set :deploy_to, "/var/www/#{application}"
set :normalize_asset_timestamps, false
set :deploy_via, :remote_cache

# You can set :scm explicitly or Capistrano will make an intelligent guess based on known version control directory names
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

set :keep_releases, 5

set :rvm_ruby_string, :local              # use the same ruby as used locally for deployment
set :rvm_autolibs_flag, "read-only"       # more info: rvm help autolibs

set :bundle_dir, ''
set :bundle_flags, '--system --quiet'

# if you want to clean up old releases on each deploy uncomment this:
# after "deploy:restart", "deploy:cleanup"

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

# If you are using Passenger mod_rails uncomment this:
# namespace :deploy do
#   task :start do ; end
#   task :stop do ; end
#   task :restart, :roles => :app, :except => { :no_release => true } do
#     run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
#   end
# end

namespace :deploy do
 task :start do ; end
 task :stop do ; end
 task :restart, :roles => :app, :except => { :no_release => true } do
   run "#{sudo} service nginx restart"
 end
end

before 'deploy:setup', 'rvm:create_gemset'
after 'deploy:update_code', 'deploy:migrate'
after 'deploy:restart', 'unicorn:reload'   # app IS NOT preloaded
after 'deploy:restart', 'unicorn:restart'  # app preloaded
after "deploy:restart", "deploy:cleanup"


set :shared_assets, %w{public/images public/images}
namespace :assets  do
  namespace :symlinks do
    desc "Setup application symlinks for shared assets"
    task :setup, :roles => [:app, :web] do
      shared_assets.each { |link| run "mkdir -p #{shared_path}/#{link}" }
    end

    desc "Link assets for current deploy to the shared location"
    task :update, :roles => [:app, :web] do
      shared_assets.each { |link| run "ln -nfs #{shared_path}/#{link} #{release_path}/#{link}" }
    end
  end
end

before "deploy:setup" do
  assets.symlinks.setup
end

before "deploy:symlink" do
  assets.symlinks.update
end


before "deploy:setup", "db:configure"
after "deploy:finalize_update", "db:symlink"

namespace :db do
desc "Create database yaml in shared path"
  task :configure do
    run "mkdir -p #{shared_path}/config"
    put db_config, "#{shared_path}/config/application.yml"
  end
  task :symlink do
    run "cp -f #{shared_path}/config/application.yml #{release_path}/config/application.yml"
  end
end