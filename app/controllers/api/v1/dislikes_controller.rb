module Api
  module V1
    class DislikesController < BaseController
      load_and_authorize_resource

      def create
        if current_user.dislikes.find_by(idea_id: params[:idea_id]).present?
          render_error
        else
          dislike = current_user.dislikes.create!(idea_id: params[:idea_id])
          like_present = false
          if current_user.likes.find_by(idea_id: params[:idea_id]).present?
            current_user.likes.find_by(idea_id: params[:idea_id]).destroy!
            like_present = true
          end
          render json: {
            "message": 'success',
            "dislike_count": RatingServise.dislikes_count(params[:idea_id]),
            "id": dislike.id,
            "like": like_present,
            "like_count": RatingServise.likes_count(params[:idea_id])
          }, status: 200
        end
      end

      def destroy
        if current_user.dislikes.find(params[:id]).present?
          dislike = current_user.dislikes.find(params[:id])
          idea_id = dislike.idea_id
          dislike.destroy!
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
        render json: {
          "message": 'success',
          "count": RatingServise.dislikes_count(idea_id)
        }, status: 200
      end
    end
  end
end
