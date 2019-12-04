class Idea < ApplicationRecord
  COUNT_WORDS_OF_PLAN = 10
  COUNT_WORDS_OF_DESCRIPTION = 10
  validates :name, length: { minimum: 4 }
  validates :plan, count_words: { minimum: COUNT_WORDS_OF_PLAN }
  validates :description, count_words: { minimum: COUNT_WORDS_OF_DESCRIPTION }
end
