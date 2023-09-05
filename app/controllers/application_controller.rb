class ApplicationController < ActionController::API
=begin
  def message
    render json: { name: "Welcome to Mock API" }
  end

  def maatapplication
    render json: {
      "id": "6c5a9afb-f410-4f8b-a75e-7b4c07d46564",
      "submitted_application": {
        "id": "6c5a9afb-f410-4f8b-a75e-7b4c07d46564",
        "parent_id": "d5122dc4-d0b2-4268-8134-7db105844379",
        "reference": 10000139,
        "created_at": "2023-07-17T09:01:37.527Z",
        "date_stamp": "2023-07-17T09:02:04.259Z",
        "case_details": {
          "urn": "",
          "offences": [
            {
              "name": "Drive a motor vehicle otherwise than in accordance with a licence",
              "dates": [
                {
                  "date_to": "2022-01-11",
                  "date_from": "2022-01-10"
                }
              ],
              "offence_class": "H",
              "slipstreamable": false
            }
          ],
          "case_type": "indictable",
          "codefendants": [],
          "hearing_date": "2024-01-21",
          "hearing_court_name": "Blackpool Magistrates' Court"
        },
        "ioj_passport": [
          "on_age_under18"
        ],
        "submitted_at": "2023-07-17T09:02:04.259Z",
        "client_details": {
          "applicant": {
            "last_name": "Walker",
            "first_name": "DO NOT MODIFY Jennifer",
            "other_names": "Ada Lovelace",
            "date_of_birth": "2005-07-18",
            "telephone_number": "",
            "correspondence_address": {
              "city": "LONDON",
              "country": "UNITED KINGDOM",
              "postcode": "N1 1RD",
              "lookup_id": "15447925",
              "address_line_one": "1",
              "address_line_two": "HAMPTON COURT"
            },
            "correspondence_address_type": "other_address"
          }
        },
        "means_passport": [
          "on_age_under18"
        ],
        "schema_version": 1,
        "application_type": "initial",
        "provider_details": {
          "office_code": "1K022G",
          "provider_email": "acox@smw-law.co.uk",
          "legal_rep_last_name": "Sandon",
          "legal_rep_telephone": "07800888888",
          "legal_rep_first_name": "John"
        },
        "interests_of_justice": []
      },
      "created_at": "2023-07-17T09:02:04.312Z",
      "updated_at": "2023-07-17T09:03:36.759Z",
      "status": "submitted",
      "submitted_at": "2023-07-17T09:02:04.259Z",
      "searchable_text": "'10000139':6 'jennif':4 'modifi':3 'walker':5",
      "review_status": "ready_for_assessment",
      "reference": 10000139,
      "applicant_first_name": "DO NOT MODIFY Jennifer",
      "applicant_last_name": "Walker",
      "offence_class": "H",
      "office_code": "1K022G"
    }
  end
=end
end
