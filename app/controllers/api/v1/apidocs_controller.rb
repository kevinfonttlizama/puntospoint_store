# app/controllers/api/v1/apidocs_controller.rb
module Api
  module V1
    class ApidocsController < ApplicationController
      def index
        redirect_to '/swagger-ui/index.html?url=/api/v1/api-docs.json'
      end
    end
  end
end
