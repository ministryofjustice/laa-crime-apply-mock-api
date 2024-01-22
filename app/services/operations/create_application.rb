require 'laa_crime_schemas'

module Operations
  class CreateApplication
    attr_reader :payload

    def initialize(payload:)
      @payload = payload

      validate!
    end

    def call
      CrimeApplication.transaction do
        @app = CrimeApplication.create!(submitted_application: payload)
        # Added this review status so that newly added applications can be retrieved
        @app.review_status = "ready_for_assessment"
        @app.save
        SupersedeApplication.new(application_id: parent_id).call if parent_id
      end

      { id: @app.id }
    end

    private

    def validate!
      schema_validator = LaaCrimeSchemas::Validator.new(payload)
      return if schema_validator.valid?

      raise LaaCrimeSchemas::Errors::ValidationError, schema_validator.fully_validate
    end

    def parent_id
      payload.fetch('parent_id', nil)
    end
  end
end
