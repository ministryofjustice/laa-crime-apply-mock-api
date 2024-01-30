module Datastore
  module V1
    module MAAT
      class Applications < Base
        version 'v1', using: :path

        resource :applications do
          desc 'Create an application.'
          route_setting :authorised_consumers, %w[maat-adapter-dev maat-adapter-uat]
          params do

            requires :application, type: JSON, desc: 'Application JSON payload.'
          end
          post do
            Operations::CreateApplication.new(
              payload: params[:application]
            ).call
          end

          desc 'Update an application.'
          params do

            requires :application, type: JSON, desc: 'Application JSON payload.'
          end
          route_setting :authorised_consumers, %w[maat-adapter-dev maat-adapter-uat]
          route_param :usn do
            put do
              if CrimeApplication.exists?(reference: params[:usn])
                Operations::UpdateApplication.new(
                  payload: params[:application]
                ).call
              else
                # If an application doesn't exist with this USN, create a new one
                Operations::CreateApplication.new(
                  payload: params[:application]
                ).call
              end
            end
          end

          desc 'Return an application by USN.'
          params do
            requires :usn, type: Integer, desc: 'Application USN.'
          end
          route_setting :authorised_consumers, %w[maat-adapter-dev maat-adapter-uat]
          route_param :usn do
            get do
             Datastore::Entities::V1::MAAT::Application.represent(
                CrimeApplication.find_by!(
                  reference: params[:usn],
                  review_status: [
                    Types::ReviewApplicationStatus['ready_for_assessment'],
                    Types::ReviewApplicationStatus['assessment_completed']
                  ]
                )
              )

            end
          end
        end
      end
    end
  end
end
