module IdeasHelper
  def user_was_interested?(idea)
    current_user.interests.find_by(idea_id: idea.id).present?
  end
end
