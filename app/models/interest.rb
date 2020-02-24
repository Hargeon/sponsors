class Interest < ApplicationRecord
  belongs_to :idea
  belongs_to :user

  COUNT_WORDS_OF_MESSAGE = 10
  MAXIMUM_LENGTH_OF_MESSAGE = 100

  validates :message, count_words: { minimum: COUNT_WORDS_OF_MESSAGE }
  validates :message, length: { maximum: MAXIMUM_LENGTH_OF_MESSAGE }
  validates_uniqueness_of :user_id, scope: :idea_id
  validates :user_id, :idea_id, presence: true
end
