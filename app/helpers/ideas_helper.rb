module IdeasHelper
  def user_was_interested?(idea)
    current_user.interests.find_by(idea_id: idea.id).present?
  end

  def views_count(idea_id)
    View.where(idea_id: idea_id).count
  end
end
