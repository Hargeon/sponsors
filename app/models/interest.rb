class Interest < ApplicationRecord
  belongs_to :idea
  belongs_to :user

  COUNT_WORDS_OF_MESSAGE = 10

  validates :message, count_words: { minimum: COUNT_WORDS_OF_MESSAGE }
  validates_uniqueness_of :user_id, scope: :idea_id
  validates :user_id, :idea_id, presence: true
end
