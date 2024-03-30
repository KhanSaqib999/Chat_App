require 'net/http'

class KeepAliveJob < ApplicationJob
  queue_as :default

  def perform
    uri = URI(ENV['SERVER'] + '/health')
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true if uri.scheme == 'https'
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE

    request = Net::HTTP::Get.new(uri)
    response = http.request(request)

    if response.is_a?(Net::HTTPSuccess)
      Rails.logger.info("Health check successful: #{response}")
    else
      Rails.logger.error("Health check failed: #{response}")
    end
  end
end
