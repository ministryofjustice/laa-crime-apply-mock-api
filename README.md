# LAA Crime Apply Mock API

This application is created for LAA Crime Application Adaptor. 

## Table of Contents
- [**Contact the team**](#contact-the-team)
- [**Environments**](#environments)
- [**Dependencies**](#dependencies)
- [**Set up (Docker)**](#set-up)
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
## Set up (Docker)

You should run the application using Docker. To do so, run the following commands from inside the project directory:

```
docker-compose build
```
```
docker-compose up
```

The database will be set up as part of the build command above. The application will run at http://localhost:3003/.

## Contributing

Bug reports and pull requests are welcome.

1. Clone the project (https://github.com/ministryofjustice/laa-crime-apply-mock-api)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit until you are happy with your contribution (`git commit -am 'Add some feature'`)
4. Push the branch (`git push origin my-new-feature`)
5. Make sure your changes are covered by tests, so that we don't break it unintentionally in the future.
6. Create a new pull request.
