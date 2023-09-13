module Datastore
  module V1
    module MAAT
      class Applications < Base
        version 'v1', using: :path

        route_setting :authorised_consumers, %w[crime-apply]

        resource :applications do
          desc 'Return an application by USN.'
          params do
            requires :usn, type: Integer, desc: 'Application USN.'
          end
          route_param :usn do
            get do
              path = 'db/data/crimeApplyDatastoreTestData.json'
              data = File.read(path)
              episodes = JSON.parse(data)
              result = []
              episodes.each do |hash|
                result << hash["submitted_application"] if hash["reference"] == params[:usn] && hash["review_status"] == "ready_for_assessment"
              end
              p result

              # the code below for return application from DB

=begin
             Datastore::Entities::V1::MAAT::Application.represent(
                CrimeApplication.find_by!(
                  reference: params[:usn],
                  review_status: Types::ReviewApplicationStatus['ready_for_assessment']
                )
              )
=end
            end
          end
        end
      end
    end
  end
end
