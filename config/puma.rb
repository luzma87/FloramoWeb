workers Integer(ENV['WEB_CONCURRENCY'] || 2)
threads_count = Integer(ENV['MAX_THREADS'] || 5)
threads threads_count, threads_count

preload_app!

# pidfile 'tmp/pids/puma.pid'
# state_path 'tmp/pids/puma.state'

# rackup "config.ru"

rackup      DefaultRackup
port        ENV['PORT']     || 3000
environment ENV['RACK_ENV'] || 'development'

# on_worker_boot do
# Worker specific setup for Rails 4.1+
# See: https://devcenter.heroku.com/articles/deploying-rails-applications-with-the-puma-web-server#on-worker-boot
# ActiveRecord::Base.establish_connection
# DataMapper.setup(:default, ENV['DATABASE_URL'] || 'postgres://postgres:postgres@localhost/kushki')
# end
