class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :rack_mini_profiler_authorize_request
  before_action :set_locale
  after_action :store_location
  before_action :friend_request
  after_action :flash_to_headers

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

  def set_locale
    save_session_locale
    I18n.locale = session[:locale] || I18n.default_locale
  end

  def save_session_locale
    session[:locale] = params[:locale] if params[:locale]
  end

  def store_location
    unless request.path == "/users/sign_in" ||
      request.path == "/users/sign_out" ||
      request.xhr?
      session[:previous_url] = request.fullpath
    end
  end

  def after_sign_in_path_for _resourse
    session[:previous_url] || root_path
  end

  def friend_request
    if !current_user.nil? && user_signed_in?
      @user_request = current_user.requested_friends.includes :avatar
    end
  end

  def flash_to_headers
    return unless request.xhr?
    response.headers["X-Message"] = flash_message
    response.headers["X-Message-Type"] = flash_type.to_s
    flash.discard
  end

  def flash_message
    [:danger, :success].each do |type|
      return flash[type] unless flash[type].blank?
    end
  end

  def flash_type
    [:danger, :success].each do |type|
      return type unless flash[type].blank?
    end
  end
end
