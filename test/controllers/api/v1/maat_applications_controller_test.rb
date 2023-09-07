require "test_helper"

class Api::V1::MaatApplicationsControllerTest < ActionController::TestCase
  test "should create a new maat application with JSON data" do
    post :create, params: {
        "id": "123",
        "schema_version": 1,
        "reference": 12,
        "application_type": "initial",
        "submitted_at": "2019-10-12T07:20:50.52Z",
        "declaration_signed_at": "2020-10-12T07:20:50.52Z",
        "date_stamp": "2021-10-12T07:20:50.52Z",
        "provider_details": {
          "office_code": "1234",
          "provider_email": "test@test.com",
          "legal_rep_first_name": "Jim",
          "legal_rep_last_name": "Bob",
          "legal_rep_telephone": "123456789"
        },
        "client_details": {
          "applicant": {
            "first_name": "Suzie123",
            "last_name": "Smith",
            "other_names": "",
            "date_of_birth": "1990-10-01",
            "nino": "ABC123",
            "telephone_number": "123456789",
            "correspondence_address_type": "home_address",
            "home_address": {
              "lookup_id": "5",
              "address_line_one": "Line 1 updated",
              "address_line_two": "Line 2",
              "city": "City",
              "country": "Country",
              "postcode": "Postcode"
            },
            "correspondence_address": {
              "lookup_id": "6",
              "address_line_one": "Line 1",
              "address_line_two": "Line 2 updated",
              "city": "City",
              "country": "Country",
              "postcode": "Postcode"
            }
          }
        },
        "case_details": {
          "urn": "urn4442",
          "case_type": "summary_only",
          "appeal_maat_id": "123",
          "appeal_lodged_date": "2020-12-23",
          "appeal_with_changes_details": "test",
          "offence_class": "C",
          "hearing_court_name": "court123",
          "hearing_date": "2020-10-11"
        },
        "interests_of_justice": [
          {
            "type": "loss_of_liberty",
            "reason": "first reason"
          },
          {
            "type": "suspended_sentence",
            "reason": "second reason"
          }
        ]
      }.to_json, 'CONTENT_TYPE' => 'application/json'
    assert_response :redirect
  end
end
