class RatingServise
  def self.likes_count(id)
    Like.where(idea_id: id).count
  end

  def self.dislikes_count(id)
    Dislike.where(idea_id: id).count
  end
end
