module Devise
  module Oauth2
    class Engine < Rails::Engine
      config.devise_oauth2_rails4 = ActiveSupport::OrderedOptions.new
      config.devise_oauth2_rails4.access_token_expires_in       = 15.minutes
      config.devise_oauth2_rails4.refresh_token_expires_in      = 1.month
      config.devise_oauth2_rails4.authorization_code_expires_in = 1.minute

      engine_name 'oauth2'
      isolate_namespace Devise::Oauth2
      initializer "devise_oauth2_rails4.initialize_application", :before=> :load_config_initializers do |app|
        app.config.filter_parameters << :client_secret
      end
    end
  end
end
