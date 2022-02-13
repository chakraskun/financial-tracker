require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module UsahaExpress
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.1
    config.autoloader = :classic

    I18n.config.available_locales = [:id, :en]
    I18n.default_locale = :id
    config.i18n.fallbacks = [:id, :en]

    config.generators do |g|
      g.template_engine = :slim
      g.orm :active_record, primary_key_type: :uuid
    end

    config.assets.paths << Rails.root.join("app", "assets", "fonts")

    # disable ActiveStorage Analyzers and Previewers
    config.active_storage.analyzers = []
    config.active_storage.previewers = []

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    
    config.to_prepare do
      Clearance::PasswordsController.layout "session"
      Clearance::UsersController.layout "session"
    end
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")
  end
end
