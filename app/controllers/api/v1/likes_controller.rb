module Api
  module V1
    class LikesController < BaseController
      load_and_authorize_resource

      def create
        if current_user.likes.find_by(idea_id: params[:idea_id]).present?
          render_error
        else
          like = current_user.likes.create!(idea_id: params[:idea_id])
          dislike_present = false
          if current_user.dislikes.find_by(idea_id: params[:idea_id]).present?
            current_user.dislikes.find_by(idea_id: params[:idea_id]).destroy!
            dislike_present - true
          end
          render json: {
            "message": 'success',
            "like_count": RatingServise.likes_count(params[:idea_id]),
            "id": like.id,
            "dislike": dislike_present,
            "dislike_count": RatingServise.dislikes_count(params[:idea_id])
          }, status: 200
        end
      end

      def destroy
        if current_user.likes.find(params[:id]).present?
          like = current_user.likes.find(params[:id])
          idea_id = like.idea_id
          like.destroy!
          render_success(idea_id)
        else
          render_error
        end
      end

      private

      def render_error
        render json: { "message": 'error' }, status: 400
      end

      def render_success(idea_id)
        render json: { "message": 'success', "like_count": RatingServise.likes_count(idea_id) }, status: 200
      end
    end
  end
end
