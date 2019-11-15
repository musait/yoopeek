require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Yoopeek
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2
    config.i18n.available_locales = [:en, :fr,:de]
    config.i18n.default_locale = :fr
    config.autoload_paths += %W(#{Rails.root}/app/models/user)
    config.autoload_paths += %W(#{config.root}/lib/modules)
    config.active_storage.service = :amazon
    config.eager_load_paths << "#{Rails.root}/lib/modules"
    config.eager_load_paths << "#{Rails.root}/app/models/user"
    config.exceptions_app = self.routes
    config.assets.paths << "#{Rails.root}/app/assets/videos"
    config.assets.enabled = true
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
  end
end
