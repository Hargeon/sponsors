module Api
  module V1
    class AutofillsController < BaseController
      def create
        render json: AutofillSerializer.new(SearchService.new(params[:term]).union), status: 200
      end
    end
  end
end
