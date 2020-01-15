class RatingServise
  def self.likes_count(id)
    Idea.find(id).likes.count
  end

  def self.dislikes_count(id)
    Idea.find(id).dislikes.count
  end
end
