require 'simple_jwt_auth'
require 'openssl'

Rails.application.config.to_prepare do
  SimpleJwtAuth.configure do |config|
    # Use same logger from Grape API
    config.logger = Datastore::Base.logger

    # Log level inherited from Rails logger, by default
    # `debug` in development/test and `info` in production
    config.logger.level = Rails.logger.level

    config.algorithm = 'HS256'

    # A map of consumers of the API and their secrets
    # On kubernetes, secrets are created by terraform
    config.secrets_config = {
      'maat-adapter-dev' => ENV.fetch('API_AUTH_SECRET_MAAT_ADAPTER_DEV', nil),
      'maat-adapter-test' => ENV.fetch('API_AUTH_SECRET_MAAT_ADAPTER_TEST', nil)
    }
  end
end