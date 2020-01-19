class RatingServise
  def self.likes_count(id)
    Like.where(idea_id: id).count
  end

  def self.dislikes_count(id)
    Dislike.where(idea_id: id).count
  end

  def self.can_create_rating?(current_user, idea_id)
    return false if current_user&.ratings&.where(idea_id: idea_id).present?

    true
  end
end
