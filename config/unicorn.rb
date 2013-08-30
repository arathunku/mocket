# https://devcenter.heroku.com/articles/rails-unicorn
APP_PATH = ENV["RAILS_ROOT"]
RAILS_ENV = ENV['RAILS_ENV'] || 'production'

worker_processes (ENV['WEB_CONCURRENCY'] || 1).to_i
timeout (ENV['WEB_TIMEOUT'] || 30).to_i
preload_app true

#user 'apps', 'apps'

listen "/tmp/unicorn.sock", :backlog => 64

stderr_path APP_PATH + "/log/unicorn.stderr.log"
stdout_path APP_PATH + "/log/unicorn.stdout.log"

pid "#{APP_PATH}/tmp/pids/unicorn.pid"


if GC.respond_to?(:copy_on_write_friendly=)
  GC.copy_on_write_friendly = true
end


before_fork do |server, worker|
  old_pid = APP_PATH + '/tmp/pids/unicorn.pid.oldbin'
  if File.exists?(old_pid) && server.pid != old_pid
    begin
      Process.kill("QUIT", File.read(old_pid).to_i)
    rescue Errno::ENOENT, Errno::ESRCH
      # someone else did our job for us
    end
  end

  if defined? ActiveRecord::Base
    ActiveRecord::Base.connection.disconnect!
  end
end

after_fork do |server, worker|
  Signal.trap 'TERM' do
    puts 'Unicorn worker intercepting TERM and doing nothing. Wait for master to sent QUIT'
  end

  if defined? ActiveRecord::Base
    ActiveRecord::Base.establish_connection
  end

  begin
    uid, gid = Process.euid, Process.egid
    user, group = 'ubuntu', 'ubuntu'
    target_uid = Etc.getpwnam(user).uid
    target_gid = Etc.getgrnam(group).gid
    worker.tmp.chown(target_uid, target_gid)
    if uid != target_uid || gid != target_gid
      Process.initgroups(user, target_gid)
      Process::GID.change_privilege(target_gid)
      Process::UID.change_privilege(target_uid)
    end
  rescue => e
    if RAILS_ENV == 'development'
      STDERR.puts "couldn't change user, oh well"
    else
      raise e
    end
  end
end
