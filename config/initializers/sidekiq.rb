# sidekiq job to keep alive

Sidekiq::Cron::Job.create(name: 'Keep Alive Request', cron: '*/5 * * * *', class: 'KeepAliveJob')
