module InterestsHelper
  def idea_interests_count(idea_id)
    Interest.where(idea_id: idea_id).count
  end
end
