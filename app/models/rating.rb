class Rating < ApplicationRecord
  belongs_to :user
  belongs_to :idea

  MINIMUM_RATING = 1
  MAXIMUM_RATING = 5

  validates :attraction, :strategy, :competitiveness, :finance, numericality: {
    greater_than_or_equal_to: MINIMUM_RATING,
    less_than_or_equal_to: MAXIMUM_RATING
  }

  validates_uniqueness_of :user_id, scope: :idea_id
end
