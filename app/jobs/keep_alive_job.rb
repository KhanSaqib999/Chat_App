class KeepAliveJob < ApplicationJob
  queue_as :default

  def perform
    response = HTTP.get(ENV['SERVER'] + '/health_check', ssl_context: OpenSSL::SSL::SSLContext.new.tap { |ctx| ctx.set_params(verify_mode: OpenSSL::SSL::VERIFY_NONE) })
    if response.status.success?
      Rails.logger.info("Health check successful: #{response}")
    else
      Rails.logger.error("Health check failed: #{response}")
    end
  end
end
