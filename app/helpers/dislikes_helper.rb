module DislikesHelper
  def dislike_present?(idea)
    current_user.dislikes.find_by(idea_id: idea.id).present?
  end

  def dislike_id(idea)
    current_user.dislikes.find_by(idea_id: idea.id).id
  end
end