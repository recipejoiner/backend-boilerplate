# Puma can serve each request in a thread from an internal thread pool.
# The `threads` method setting takes two numbers: a minimum and maximum.
# Any libraries that use thread pools should be configured to match
# the maximum value specified for Puma. Default is set to 5 threads for minimum
# and maximum; this matches the default thread size of Active Record.
#
max_threads_count = ENV.fetch("RAILS_MAX_THREADS") { 5 }
min_threads_count = ENV.fetch("RAILS_MIN_THREADS") { max_threads_count }
threads min_threads_count, max_threads_count

# Specifies the `port` that Puma will listen on to receive requests; default is 3000.
#
port        ENV.fetch("PORT") { 3000 }

# Specifies the `environment` that Puma will run in.
#
environment ENV.fetch("RAILS_ENV") { "development" }

# Specifies the `pidfile` that Puma will use.
pidfile ENV.fetch("PIDFILE") { "tmp/pids/server.pid" }

# Specifies the number of `workers` to boot in clustered mode.
# Workers are forked web server processes. If using threads and workers together
# the concurrency of the application would be max `threads` * `workers`.
# Workers do not work on JRuby or Windows (both of which do not support
# processes).
#
# workers ENV.fetch("WEB_CONCURRENCY") { 2 }

# Use the `preload_app!` method when specifying a `workers` number.
# This directive tells Puma to first boot the application and load code
# before forking the application. This takes advantage of Copy On Write
# process behavior so workers use less memory.
#
# preload_app!

# Allow puma to be restarted by `rails restart` command.
plugin :tmp_restart

# Configure rails on development
if Rails.env.development?
# Bind localhost to SSL, if using that (see the bottom of config/environments/development.rb)
# rails s -b 'ssl://127.0.0.1:3001?key=config/ssl/api.devwork.shmob.key&cert=config/ssl/api.devwork.shmob.crt'
# If this thorws an 'address already in use' error, you can run the following to see what's using that port on localhost:
# lsof -wni tcp:3001
# Note that because the non-ssl port is 3000, this port is 3001
ssl_bind '127.0.0.1', '3001', {
  key: "config/ssl/devwork.shmob4-key.pem",
  cert: "config/ssl/devwork.shmob4.pem",
  verify_mode: 'none'
}
end