module Api
  module V1
    class LikesController < BaseController
      load_and_authorize_resource

      def create
        like = LikeServise.new(current_user, params[:idea_id]).create_like
        if like
          render json: LikeDislikeResponseSerializer.new(like, params[:idea_id]), status: 200
        else
          render_error
        end
      end

      def destroy
        like = LikeServise.new(current_user).destroy_like(params[:id])
        if like
          render json: like, status: 200
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
