require "json"
require "json-schema"
require_relative '../../../services/maat_applications/validator_builder'
require_relative '../../../services/maat_applications/manager'


module Api
  module V1
    class MaatApplicationsController < ApplicationController
      def create
        validator = ValidatorBuilder.new
        # Whitelist the fields that we are allowed to populate
        permitted_fields = validator.build_permitted_fields_object

        # Create a service to save the application
        maat_application_manager = Manager.new

        # Validate the provided data
        submitted_maat_details = maat_application_manager.maat_application_params(params, permitted_fields[:maat_application]).to_h
        validator.validate(params, submitted_maat_details, permitted_fields)

        if maat_application_manager.create_new_application(params, permitted_fields)
          render json: { message: 'A new MAAT application has been successfully created.' }, status: 200
        else
          render json: { message: 'Unable to create the MAAT application.'}, status: 400
        end
      end

      # PUT
      def update
        validator = ValidatorBuilder.new
        # Whitelist the fields that we are allowed to populate
        permitted_fields = validator.build_permitted_fields_object

        # Create a service to save the application
        maat_application_manager = Manager.new

        # Validate the provided data
        submitted_maat_details = maat_application_manager.maat_application_params(params, permitted_fields[:maat_application]).to_h
        validator.validate(params, submitted_maat_details, permitted_fields)

        maat_application = MaatApplication.find_by_maat_id(params[:id])
        # @properties = PropertiesOld.find_by_maat_application_id(params[:id])
        if maat_application
          if maat_application_manager.update_existing_application(maat_application, params, permitted_fields)
            render json: { message: 'Existing MAAT application successfully updated.' }, status: 200
          else
            render json: { message: 'Unable to update the MAAT application.'}, status: 400
          end
        else
          if maat_application_manager.create_new_application(params, permitted_fields)
            render json: { message: 'No MAAT application has been found with the provided ID.
      A new MAAT application has been successfully created.' }, status: 200
          else
            render json: { message: 'Unable to create the MAAT application.'}, status:400
          end
        end
      end
    end
  end
end
