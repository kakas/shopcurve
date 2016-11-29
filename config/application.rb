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
    config.to_prepare do
      Devise::SessionsController.layout "devise"
    end
    config.active_job.queue_adapter = :delayed_job
  end
end
