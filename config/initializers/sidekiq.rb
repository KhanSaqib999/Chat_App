# sidekiq job to keep alive
require 'sidekiq'

Sidekiq.configure_server do |config|
  config.redis = { url: ENV['REDIS_URL'] }
end

Sidekiq.configure_client do |config|
  config.redis = { url: ENV['REDIS_URL'] }
end

Sidekiq::Cron::Job.create(name: 'Keep Alive Request', cron: '*/5 * * * *', class: 'KeepAliveJob')
