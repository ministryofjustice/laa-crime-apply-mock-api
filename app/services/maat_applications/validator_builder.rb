# frozen_string_literal: true

class ValidatorBuilder

  # Determine which fields are permitted to be populated based on the JSON schemas
  def build_permitted_fields_object_old
    schema = get_schema
    permitted_fields = []

    schema.properties.each_pair do |attr_name, attr_value|
      permitted_fields.push(attr_name)
    end

    return permitted_fields
  end

  def build_permitted_fields_object_schema_old
    schema = JSON.parse(get_schema, object_class: OpenStruct)
    permitted_fields = []

    # maat_application is the initial key - this will change for any sub-objects that are found
    iterate(schema.properties, :maat_application)
    return @permitted_fields
  end

  def build_permitted_fields_object
    @permitted_fields = {
      :maat_application => [
        :id,
        :schema_version,
        :reference,
        :application_type,
        :submitted_at,
        :declaration_signed_at,
        :date_stamp
      ],
      :provider_details => [
        :office_code,
        :provider_email,
        :legal_rep_first_name,
        :legal_rep_last_name,
        :legal_rep_telephone
      ],
      :case_details => [
        :urn,
        :case_type,
        :appeal_maat_id,
        :appeal_lodged_date,
        :appeal_with_changes_details,
        :offence_class,
        :hearing_court_name,
        :hearing_date
      ],
      :client_details => [
      ],
      :applicant => [
        :first_name,
        :last_name,
        :other_names,
        :date_of_birth,
        :nino,
        :telephone_number,
        :correspondence_address_type
      ],
      :home_address => [
        :lookup_id,
        :address_line_one,
        :address_line_two,
        :city,
        :country,
        :postcode
      ],
      :correspondence_address => [
        :lookup_id,
        :address_line_one,
        :address_line_two,
        :city,
        :country,
        :postcode
      ],
      :interests_of_justice => [
        :type,
        :reason
      ]
    }

    return @permitted_fields
  end

  def initialize
    super
    @permitted_fields = { }
  end

  def iterate(h, group)
    test_array = []
    h.each_pair do |k, v|
      if v.is_a?(Hash) || v.is_a?(Array) || (v.is_a?(Object) && v.type == 'object')
        # test_array.push(k)
        @permitted_fields[group] = test_array
        group = k
        iterate(v.properties, group)
        return
      else
        test_array.push(k)

        puts("k is #{k}, value is #{v}")
      end
    end
    @permitted_fields[group] = test_array

    # TODO: Create nested arrays with maat_application: {}, case_details: {} etc. Can then refer to specific one when permitting fields
    # params.require(:maat_application)
    #       .permit(:title, :description,
    #               properties: [:schema_version, :reference])
  end



  def register_custom_validation
    date_formatter = -> value {
      begin
        Date.iso8601(value)
      rescue ArgumentError
        raise JSON::Schema::CustomFormatError.new('must be in date format: YYYY-MM-DD')
      end
    }
    JSON::Validator.register_format_validator("date", date_formatter)
  end

  def validate(params, submitted_maat_details, permitted_fields)
    # Get the schema to validate against
    schema = get_schema

    # Register any custom validation rules we have
    register_custom_validation
    test = params
    # Get the data into hashes so we can validate
    submitted_provider_details = params.require(:provider_details).permit(permitted_fields[:provider_details]).to_h
    submitted_applicant_details = params.require(:client_details).require(:applicant).permit(permitted_fields[:applicant]).to_h
    submitted_home_address_details = params.require(:client_details).require(:applicant).require(:home_address).permit(permitted_fields[:home_address]).to_h
    submitted_correspondence_address_details = params.require(:client_details).require(:applicant).require(:correspondence_address).permit(permitted_fields[:correspondence_address]).to_h
    submitted_case_details = params.require(:case_details).permit(permitted_fields[:case_details]).to_h

    # Validate the data
    JSON::Validator.validate!(schema, submitted_maat_details, :fragment => "#/")
    JSON::Validator.validate!(schema, submitted_provider_details, :fragment => "#/properties/provider_details")
    JSON::Validator.validate!(schema, submitted_applicant_details, :fragment => "#/properties/client_details/properties/applicant")
    JSON::Validator.validate!(schema, submitted_home_address_details, :fragment => "#/properties/client_details/properties/applicant/properties/home_address")
    JSON::Validator.validate!(schema, submitted_correspondence_address_details, :fragment => "#/properties/client_details/properties/applicant/properties/correspondence_address")
    JSON::Validator.validate!(schema, submitted_case_details, :fragment => "#/properties/case_details")
    params[:interests_of_justice].each_with_index do |ioj, index|
      submitted_interest_of_justice = params.permit(interests_of_justice: permitted_fields[:interests_of_justice]).to_h
      JSON::Validator.validate!(schema, submitted_interest_of_justice[:interests_of_justice][index], :fragment => "#/properties/interests_of_justice/items")
    end
  end

  private
  def get_schema
    schema_file = File.open("app/assets/schemas/1.0/maat_application.json")
    file_data = schema_file.read
    schema_file.close

    # schema_file = File.open("app/assets/schemas/1.0/general/provider.json")
    # provider_data = schema_file.read
    # schema_test = schema_file.read

    # provider_json_file = JSON.parse(provider_data, object_class: OpenStruct)
    # test2 = provider_json_file['$schema']
    #
    # JSON::Validator.schema_reader = JSON::Schema::Reader.new(:accept_uri => true, :accept_file => true)
    # provider_schema = JSON::Schema.new(provider_json_file, Addressable::URI.parse("app/assets/schemas/1.0/provider.json"))
    # JSON::Validator.add_schema(provider_schema)
    # schema_file.close

    return file_data
    # JSON.parse(file_data, object_class: OpenStruct)
  end

  private
  def maat_application_params(permitted)
    # Perhaps can build this up by parsing the schemas?
    # params.require(:maat_application).permit(permitted)

    # params.require(:maat_application).permit(:title, :properties).tap do |whitelisted|
    #   whitelisted[:properties] = params[:maat_application][:properties]
    #end

    # params.require(:maat_application)
    #       .permit(:title, :description,
    #               properties: [:schema_version, :reference])
    permitted.push(:maat_id)
    # params[:maat_id] = params[:id]
    # params_final = params.merge(:maat_id => '123')
    # params = params.merge(maat_id: params[:id])
    params.require(:maat_application).permit(permitted).except(:id).merge(maat_id: params[:id])
  end
end
