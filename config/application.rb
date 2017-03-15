require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Fcsp
  class Application < Rails::Application
    # Settings in config/environments/* take precedence
    # over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
    config.assets.paths << Rails.root.join("app", "assets", "videos")

    config.rack_mini_profiler_environments = %w(development)
    config.i18n.load_path << Rails.root.join(
      "config", "locales", "**", "*.{rb,yml}"
    )
  end
end
