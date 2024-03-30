class ApplicationController < ActionController::API
  before_action :start_keep_alive_job

  private

  def start_keep_alive_job
    KeepAliveJob.perform_later
  end
end
