class RatingServise
  def self.likes_count(id)
    Like.where(idea_id: id).count
  end

  def self.dislikes_count(id)
    Dislike.where(idea_id: id).count
  end

  def self.can_create_rating?(current_user, idea_id)
    return false if current_user&.ratings&.where(idea_id: idea_id).present?

    current_user&.sponsor?
  end

  def self.show_current_user_rating?(current_user, idea_id)
    return false unless current_user&.sponsor?

    current_user&.ratings&.where(idea_id: idea_id).present?
  end

  def self.average_rating(idea)
    ratings = Rating.where(idea_id: idea.id)
    sum = 0
    count = 0
    ratings.each do |rating|
      sum += (rating.attraction + rating.strategy + rating.competitiveness + rating.finance) / 4
      count += 1
    end

    begin
      sum / count
    rescue ZeroDivisionError
      0
    end
  end

  def self.count_votes(idea)
    Rating.where(idea_id: idea.id).count
  end
end
