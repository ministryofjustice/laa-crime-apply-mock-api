module Datastore
  module V1
    module Maat
      class Applications < Base
        version 'v1', using: :path

        #route_setting :authorised_consumers, %w[maat-adapter-dev maat-adapter-uat]

        resource :applications do
          desc 'Return an application by USN.'
          params do
            requires :usn, type: Integer, desc: 'Application USN.'
          end
          route_param :usn do
            get do
              print params[:usn]
              Datastore::Entities::V1::Maat::Application.represent(
                #CrimeApplication.find(reference: params[:usn])
              )
            end
          end
        end
      end
    end
  end
end
