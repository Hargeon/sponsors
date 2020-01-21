class LikeService
  def initialize(current_user, idea_id = nil)
    @idea_id = idea_id
    @current_user = current_user
  end

  def destroy_like(id)
    return false unless like_present_by_id?(id)

    like = @current_user.likes.find(id)
    idea_id = like.idea_id
    like.destroy!

    {
      'message': 'success',
      'like_count': RatingService.likes_count(idea_id)
    }
  end

  def create_like
    return false if like_present_by_idea?

    like = @current_user.likes.create!(idea_id: @idea_id)

    dislike_present = @current_user.dislikes.find_by(idea_id: @idea_id).present?
    @current_user.dislikes.find_by(idea_id: @idea_id).destroy! if dislike_present

    { 'id': like.id, 'dislike': dislike_present }
  end

  private

  def like_present_by_idea?
    @current_user.likes.find_by(idea_id: @idea_id).present?
  end

  def like_present_by_id?(id)
    @current_user.likes.find(id).present?
  end
end
