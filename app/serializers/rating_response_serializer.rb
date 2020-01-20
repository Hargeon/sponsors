class RatingResponseSerializer
  def initialize(rating)
    @idea = Idea.find(rating.idea_id)
  end

  def as_json(*)
    {
      'message': 'success',
      'average_rating': RatingServise.average_rating(@idea),
      'count_votes': RatingServise.count_votes(@idea)
    }
  end
end
