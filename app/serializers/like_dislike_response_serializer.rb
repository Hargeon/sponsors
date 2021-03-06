class LikeDislikeResponseSerializer
  def initialize(data, idea_id)
    @data = data
    @idea_id = idea_id
  end

  def as_json(*)
    {
      'message': 'success',
      'dislike_count': RatingService.dislikes_count(@idea_id),
      'like_count': RatingService.likes_count(@idea_id)
    }.merge(@data)
  end
end
