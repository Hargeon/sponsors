module Api
  module V1
    class RatingsController < BaseController
      load_and_authorize_resource

      def create
        @rating = current_user.ratings.new(rating_params)
        if @rating.save
          render json: RatingResponseSerializer.new(@rating), status: 200
        else
          I18n.locale = params[:locale]
          render json: { 'message': I18n.t('stars') }, status: 400
        end
      end

      private

      def rating_params
        params.require(:rating).permit(:idea_id, :attraction,
                                       :strategy, :competitiveness, :finance)
      end
    end
  end
end
