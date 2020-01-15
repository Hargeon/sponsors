module LikesHelper
  def like_present?(idea)
    current_user.likes.find_by(idea_id: idea.id).present?
  end

  def like_id(idea)
    current_user.likes.find_by(idea_id: idea).id
  end
end
