class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :rack_mini_profiler_authorize_request
  before_action :set_locale

  include ApplicationHelper
  include PublicActivity::StoreController

  rescue_from ActiveRecord::RecordNotFound, with: :not_found

  rescue_from CanCan::AccessDenied do |exception|
    flash[:alert] = exception.message
    redirect_to root_path
  end

  private
  def rack_mini_profiler_authorize_request
    environments = Rails.application.config.rack_mini_profiler_environments
    return unless Rails.env.in? environments
    Rack::MiniProfiler.authorize_request
  end

  def after_sign_out_path_for _resource
    root_path
  end

  def set_locale
    save_session_locale
    I18n.locale = session[:locale] || I18n.default_locale
  end

  def save_session_locale
    session[:locale] = params[:locale] if params[:locale]
  end
end
