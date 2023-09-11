require 'test_helper'

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
end
