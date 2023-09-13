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

## Generate JWT and Authenticate With Mock Application

This mock API utilizes symmetrical HS256 encryption using a shared private secret to authenticate/authorise.
To test this app locally we can generate our own JWT using a Java command line app at the root of the project, 
specifically made for this purpose. This java jar app is called command-line-jwt-generator.jar and to use this:

1. run "java -jar command-line-jwt-generator.jar <BASE_64_ENCODED_SECRET_FOUND_IN_ENV_DEVELOPMENT> <ISSUER>" from the root directory 
2. As you can see it takes two parameters: a base64 encoded string that can be found in the relevant .env file BASE64 decoded (you need to encode); Also, an issuer - this is the app that would normally be issuing the JWT. In our case "crime-apply" would normally issue this JWT to communicate to our mock.
3. When we call the app endpoint using Postman/CURL we can now use this Bearer token JWT to authenticate/authorize with our app.