module Api
  module V1
    class DislikesController < BaseController
      load_and_authorize_resource

      def create
        dislike = DislikeServise.new(current_user, params[:idea_id]).create_dislike
        if dislike
          render json: LikeDislikeResponseSerializer.new(dislike, params[:idea_id]), status: 200
        else
          render_error
        end
      end

      def destroy
        dislike = DislikeServise.new(current_user).destroy_dislike(params[:id])
        if dislike
          render json: dislike, status: 200
        else
          render_error
        end
      end

      private

      def render_error
        render json: { 'message': 'error' }, status: 400
      end
    end
  end
end
