# frozen_string_literal: true

class Settings
  include Support::Utils

  PORT = Integer(get_env_or_raise_exception('PORT'))
  RAILS_MIN_THREADS = Integer(get_env_or_raise_exception('RAILS_MIN_THREADS'))
  RAILS_MAX_THREADS = Integer(get_env_or_raise_exception('RAILS_MAX_THREADS'))
  WEB_CONCURRENCY = Integer(get_env_or_raise_exception('WEB_CONCURRENCY'))
  PUMA_PIDFILE = get_env_or_raise_exception('PUMA_PIDFILE')
  DB_ADAPTER = get_env_or_raise_exception('DB_ADAPTER')
  DB_ENCODING = get_env_or_raise_exception('DB_ENCODING')
  DB_DATABASE_NAME = get_env_or_raise_exception('DB_DATABASE_NAME')
  DB_USER = get_env_or_raise_exception('DB_USER')
  DB_PASSWORD = get_env_or_raise_exception('DB_PASSWORD')
  DB_HOST = get_env_or_raise_exception('DB_HOST')
  DB_PORT = get_env_or_raise_exception('DB_PORT')
end
