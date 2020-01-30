module Api
  module V1
    class AutofillsController < BaseController
      def create
        render json: AutofillSerializer.new(params[:term]), status: 200
      end
    end
  end
end
