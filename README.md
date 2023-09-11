# LAA Crime Apply Mock API

This application is created for LAA Crime Application Adaptor. 

## Table of Contents
- [**Contact the team**](#contact-the-team)
- [**Environments**](#environments)
- [**Dependencies**](#dependencies)
- [**Set up**](#set-up)
- [**Contributing**](#contributing)

## Contact the team

Court Data Adaptor is maintained by staff in the Legal Aid Agency. If you need support, you can contact the team on our Slack channel:
- [#laa-crime-apps-core](https://mojdt.slack.com/archives/CT0Q47YCQ) on MOJ Digital & Technology

## Dependencies

* Ruby version
    * Ruby version 3.2.2
      To install various ruby versions, install a Ruby Version Manager.
      Two popular are [RVM](https://rvm.io/) and [asdf](https://asdf-vm.com/).

    * Rails 7.07

Install dependencies with bundler:
```
bundle install
```
## Set up

To set up LAA Crime Apply Mock API in your local machine, you can run the rails server manually:
- Run Rails (the application server) - rails server
- Visit http://localhost:3000/api/message

## Contributing

Bug reports and pull requests are welcome.

1. Clone the project (https://github.com/ministryofjustice/laa-crime-apply-mock-api)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit until you are happy with your contribution (`git commit -am 'Add some feature'`)
4. Push the branch (`git push origin my-new-feature`)
5. Make sure your changes are covered by tests, so that we don't break it unintentionally in the future.
6. Create a new pull request.

## API Authentication/Authorisation
How to Authenticate/Authorise APIs:

1. Edit and add to the verify_jwt.rb script an OAuth2 JWT bearer token obtained from Cognito as well as a Cognito server link to the public keys.
2. Run the verify_jwt.io script to obtain the public key to verify JWT tokens.
3. Save the public key as a public_key.pem in the config folder.
4. Edit and add the public key string to the relevant .env file or wherever you want to store the public key string.
5. Edit the simple_jwt_auth.rb script to add the relevant JWT issuer that we want to allow to access our APIs.
6. Edit the relevant API route setting to allow the new authorised consumer (JWT issuer) of that API.