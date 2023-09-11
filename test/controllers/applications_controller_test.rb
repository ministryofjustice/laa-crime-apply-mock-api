require 'test_helper'
require 'json'

class ApplicationsControllerTest < ActiveSupport::TestCase
  include Rack::Test::Methods

  def app
    Rails.application
  end

  test "should create an application if the provided data is valid" do
    path = 'test/valid_application_data.json'
    post_data = File.read(path)
    post '/api/v1/maat/applications', post_data, 'CONTENT_TYPE' => 'application/json'

    assert last_response.status == 201
  end

  test "should raise an error if the provided data is invalid" do
    path = 'test/invalid_application_data.json'
    post_data = File.read(path)

    assert_raise LaaCrimeSchemas::Errors::SchemaVersionError do
      post '/api/v1/maat/applications', post_data, 'CONTENT_TYPE' => 'application/json'
    end

  end

  test "should update an existing application if the provided data is valid" do

    # Create an application that we can modify
    existing_data_path = 'test/existing_application_data.json'
    existing_data = File.read(existing_data_path)
    existing_data_parsed = JSON.parse(existing_data, object_class: OpenStruct)
    post '/api/v1/maat/applications', existing_data, 'CONTENT_TYPE' => 'application/json'

    # Get the object of the application we've created
    existing_application = CrimeApplication.find_by(reference: existing_data_parsed.application.reference)

    # Get the data that we are going to use to override the existing object
    new_data_path = 'test/valid_application_data.json'
    new_data = File.read(new_data_path)
    new_data_parsed = JSON.parse(new_data, object_class: OpenStruct)

    put '/api/v1/maat/applications/' + existing_application.reference.to_s, new_data, 'CONTENT_TYPE' => 'application/json'

    existing_application.reload

    assert last_response.status == 200
    assert_equal(new_data_parsed.application.client_details.applicant.first_name,
                 existing_application.applicant_first_name)
    assert_equal(new_data_parsed.application.client_details.applicant.last_name,
                 existing_application.applicant_last_name)
  end
end
