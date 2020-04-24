Rails.application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

  # In the development environment your application's code is reloaded on
  # every request. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = false

  # Do not eager load code on boot.
  config.eager_load = false

  # Show full error reports.
  config.consider_all_requests_local = true

  # Enable/disable caching. By default caching is disabled.
  # Run rails dev:cache to toggle caching.
  if Rails.root.join('tmp', 'caching-dev.txt').exist?
    config.action_controller.perform_caching = true

    config.cache_store = :memory_store
    config.public_file_server.headers = {
      'Cache-Control' => "public, max-age=#{2.days.to_i}"
    }
  else
    config.action_controller.perform_caching = false

    config.cache_store = :null_store
  end

  # Store uploaded files on the local file system (see config/storage.yml for options)
  config.active_storage.service = :local

  config.action_mailer.raise_delivery_errors = true
  config.action_mailer.perform_deliveries = true
  config.action_mailer.perform_caching = false
  config.action_mailer.delivery_method = :test

  # Use this for developing on localhost
  host = 'localhost:3000' # Local server, change port number if necessary
  config.action_mailer.default_url_options = { host: host, protocol: 'http' }
  config.action_mailer.perform_caching = false

  # Print deprecation notices to the Rails logger.
  config.active_support.deprecation = :log

  # Raise an error on page load if there are pending migrations.
  config.active_record.migration_error = :page_load

  # Highlight code that triggered database queries in logs.
  config.active_record.verbose_query_logs = true


  # Raises error for missing translations
  # config.action_view.raise_on_missing_translations = true

  # Use an evented file watcher to asynchronously detect changes in source code,
  # routes, locales, etc. This feature depends on the listen gem.
  config.file_watcher = ActiveSupport::EventedFileUpdateChecker

  # If you have a custom domain in /etc/hosts, put it here
  config.hosts << "api.devwork.shmob"

  # Must use a self-signed cert for this to not make browsers mad - 
  config.force_ssl = true
  # do the following:
  # 1. Resolve a domain name to localhost in /etc/hosts (and put that domain name above)
  # 2. Install https://github.com/FiloSottile/mkcert
  # 3. Run the following Terminal, replacing 'devwork.shmob' with whatever domain name you've used in the previous step
'''
mkcert devwork.shmob "*.devwork.shmob" localhost 127.0.0.1 ::1
'''
# You may need to edit the certs output to remove a '+', which seems to make Rails mad
# Then, run (again, replacing the cert files with your own):
'''
mkdir -p config/ssl
mv devwork.shmob4.pem devwork.shmob4-key.pem config/ssl
'''
# Lastly, configure Puma to specify this ssl binding by adding the following to config/puma.rb

end