require 'simple_jwt_auth'
require 'openssl'

Rails.application.config.to_prepare do
  SimpleJwtAuth.configure do |config|
    # Use same logger from Grape API
    config.logger = Datastore::Base.logger

    # Log level inherited from Rails logger, by default
    # `debug` in development/test and `info` in production
    config.logger.level = Rails.logger.level

    config.algorithm = 'RS256'

    config.issuer = 'https://cognito-idp.eu-west-2.amazonaws.com/eu-west-2_6mJr60x9m'

    public_key_str = ENV.fetch('API_AUTH_SECRET_APPLY', nil)
    public_key = OpenSSL::PKey::RSA.new(public_key_str)

    # A map of consumers of the API and their secrets
    # On kubernetes, secrets are created by terraform
    config.secrets_config = {
      'https://cognito-idp.eu-west-2.amazonaws.com/eu-west-2_6mJr60x9m' => public_key
    }
  end
end