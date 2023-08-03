module Api
  module V1
    class ExperimentsController < ApplicationController
      before_action :find_or_init_client

      def index
        ClientSettings::PopulateService.execute(@client)
        render json: ClientSettings::IndexService.execute(@client), status: 200
      end

      private

      def find_or_init_client
        device_token = request.headers["Device-Token"]
        @client = Client.find_or_create_by(device_token: device_token)
      end
    end
  end
end
