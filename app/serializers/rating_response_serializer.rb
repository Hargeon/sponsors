class RatingResponseSerializer
  def initialize(data, idea_id)
    @data = data
    @idea_id = idea_id
  end

  def as_json(*)
    {
      "message": 'success',
      "dislike_count": RatingServise.dislikes_count(@idea_id),
      "like_count": RatingServise.likes_count(@idea_id)
    }.merge(@data)
  end
end
