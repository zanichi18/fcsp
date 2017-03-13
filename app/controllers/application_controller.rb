class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :rack_mini_profiler_authorize_request

  include ApplicationHelper

  private

  def rack_mini_profiler_authorize_request
    environments = Rails.application.config.rack_mini_profiler_environments
    return unless Rails.env.in? environments
    Rack::MiniProfiler.authorize_request
  end
end
