require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Shopcurve
  class Application < Rails::Application
    config.generators.assets = false
    config.generators.helper = false
    config.time_zone = 'Taipei'
    config.i18n.available_locales = [:en, :'zh-TW']
    config.i18n.default_locale = :'zh-TW'
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
  end
end
