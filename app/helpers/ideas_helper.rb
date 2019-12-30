module IdeasHelper
  def user_was_interested?(idea)
    if current_user.interests.find_by(idea_id: idea.id).nil?
      false
    else
      true
    end
  end
end
