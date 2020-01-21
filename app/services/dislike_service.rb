class DislikeService
  def initialize(current_user, idea_id = nil)
    @current_user = current_user
    @idea_id = idea_id
  end

  def create_dislike
    return false if dislike_present_by_idea?

    dislike = @current_user.dislikes.create!(idea_id: @idea_id)
    like_present = @current_user.likes.find_by(idea_id: @idea_id).present?
    @current_user.likes.find_by(idea_id: @idea_id).destroy! if like_present

    { 'id': dislike.id, 'like': like_present }
  end

  def destroy_dislike(id)
    return false unless dislike_present_by_id?(id)

    dislike = @current_user.dislikes.find(id)
    idea_id = dislike.idea_id
    dislike.destroy!

    {
      'message': 'success',
      'dislike_count': RatingService.dislikes_count(idea_id)
    }
  end

  private

  def dislike_present_by_idea?
    @current_user.dislikes.find_by(idea_id: @idea_id).present?
  end

  def dislike_present_by_id?(id)
    @current_user.dislikes.find(id).present?
  end
end
