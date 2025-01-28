# LAA Crime Apply Mock API

This application is created for LAA Crime Application Adaptor. 

## Table of Contents
- [**Contact the team**](#contact-the-team)
- [**Dependencies**](#dependencies)
- [**Set up (Docker)**](#set-up)
- [**Generate JWT and Authenticate With Mock Application**](#generate-jwt-and-authenticate-with-mock-application)
- [**How to use the API**](#how-to-use-the-api)
  - [**Endpoints**](#endpoints)
  - [**Data**](#data)
  - [**Example PUT request**](#example-put-request)
  - [**Example GET request**](#example-get-request)
- [**Accessing the database**](#accessing-the-database)
  - [**Via terminal**](#via-terminal)
  - [**Using a database administration tool**](#using-a-database-administration-tool)
  - [**Updating database migration files and schema.rb**](#Updating-database-migration-files-and-schema.rb)
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

### Obtaining environment variables for running locally

To run the app locally, you will need to download the appropriate environment variables from the team vault in 1Password. These environment variables are stored as a .env file, which docker-compose uses when starting up the service. If you don't see the team vault, speak to your tech lead to get access.

To begin with, make sure that you have the 1Password CLI installed:

```sh
op --version
```

If the command is not found, [follow the steps on the 1Password developer docs to get the CLI set-up](https://developer.1password.com/docs/cli/get-started/).

Once you're ready to run the application:

```sh
./start-local.sh
```

### Decrypting values files

The values YAML files are encrypted using [git-crypt](https://github.com/AGWA/git-crypt).

To be able to view and/or edit these files, you will need to decrypt them first.


The database will be set up as part of the build command above. It will be seeded with some sample records to work with. The application will run at http://localhost:3003/.

## Generate JWT and Authenticate With Mock Application

This mock API utilizes symmetrical HS256 encryption using a shared private secret to authenticate/authorise.
To test this app locally we can generate our own JWT using a Java command line app at the root of the project, 
specifically made for this purpose. This java jar app is called command-line-jwt-generator.jar and to use this:

1. run "java -jar command-line-jwt-generator.jar BASE_64_ENCODED_SECRET_FOUND_IN_ENV_DEVELOPMENT ISSUER" from the root directory 
2. As you can see it takes two parameters: a base64 encoded string that can be found in the relevant .env file BASE64 decoded (you need to encode); Also, an issuer - this is the app that would normally be issuing the JWT. In our case "maat-adapter-dev" or "maat-adapter-test" would normally issue this JWT to communicate to our mock.
3. When we call the app endpoint using Postman/CURL we can now use this Bearer token JWT to authenticate/authorize with our app.
4. On the non-production environments this shared secret will be generated by the platform and we'd need to use this.

## How to use the API

### Endpoints

The following endpoints are currently available:

- GET: http://localhost:3003/api/v1/maat/applications/10000133
- POST: http://localhost:3003/api/v1/maat/applications/
- PUT: http://localhost:3003/api/v1/maat/applications/10000133

The usn on the end of the GET and PUT is an example - you will replace this with your own as applicable.

### Data

When you ran 'docker-compose build' the database will have been seeded with sample records to use. If you wish to add your own, you can submit a request to either the POST or PUT endpoints listed above. If you submit a request to the PUT and provide a usn that doesn't exist, a new record will be created (otherwise it'll update the existing record).

### Example PUT request

1. In postman (or similar), set up a new PUT request with a URL of the following: http://localhost:3003/api/v1/maat/applications/10000133
2. Set the Authorization type to 'Bearer Token', and paste in the token generated from the 'Generate JWT and Authenticate With Mock Application' section above. Don't include the word 'Bearer' from the beginning that the tool generates.
3. Copy the contents of the 'sample_request.json' file from the root of this project and paste it into the body of your request. Set the body to 'raw' and the type to 'JSON'
4. Submit your request. If successful, it should respond with an ID.

**Important: The 'reference' value in your request body should match the urn you provide on the end the URL.**

### Example GET request

1. In postman (or similar), set up a new GET request with a URL of the following: http://localhost:3003/api/v1/maat/applications/10000133
2. Set the Authorization type to 'Bearer Token', and paste in the token generated from the 'Generate JWT and Authenticate With Mock Application' section above. Don't include the word 'Bearer' from the beginning that the tool generates.
3. Submit your request. If successful, it should respond with the data of the application with the usn you provided.

**Important: The GET request will only return applications that have a review_status of 'ready_for_assessment'. The seeded data that is generated when you 'docker-compose build' is already set to this, but any new records you add won't be at this stage. You will need to manually update this field in the database if you wish to GET the record.**

## Accessing the database

This API uses a PostgreSQL database. The database will have been generated for you as part of the docker build. Once you have the application running, you can access your database in multiple ways.

### Via terminal

If you are using docker desktop, you can click on your container and select 'Terminal'. You can log into the database by running:

```
psql -U postgres -h db -d laa-crime-apply-mock-api
```

From here you can use SQL commands. You may want to update the review status on records so that you can retrieve them via the API. To update **all** records with this status, run: 

```
UPDATE crime_applications SET review_status = 'ready_for_assessment';
```

### Using a database administration tool

If you are using a tool on your machine to connect to the database, you will need to set the following values:

- URL: jdbc:postgresql://localhost:5432/laa-crime-apply-mock-api
- Host: localhost
- Port: 5432
- Database: laa-crime-apply-mock-api
- Username: postgres

Password should be left blank.

### Updating database migration files and schema.rb
When making changes to the database using the migration files, [this](https://guides.rubyonrails.org/active_record_migrations.html#generating-migrations) provides useful guidance. 
1. You can generate a new migrate files with this command: `bin/rails generate migration <db_update_descriptive_name>`
2. You can add your updates to this file. It should be possible to make these changes by comparing with the [Crime Apply application](https://github.com/ministryofjustice/laa-criminal-applications-datastore).
3. Following changes you will want to run `bin/rails db:create` in order to create your database on your machine, this is necessary for the next step. 
4. Next run `bin/rails db:migrate` which will update your schema.rb with your changes. 
5. Now you can set up and run the application locally to test the changes have been made. 


## Contributing

Bug reports and pull requests are welcome.

1. Clone the project (https://github.com/ministryofjustice/laa-crime-apply-mock-api)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit until you are happy with your contribution (`git commit -am 'Add some feature'`)
4. Push the branch (`git push origin my-new-feature`)
5. Make sure your changes are covered by tests, so that we don't break it unintentionally in the future.
6. Create a new pull request.