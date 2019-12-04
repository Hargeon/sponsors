class Idea < ApplicationRecord
  has_many :industries, through: :local_industries

  COUNT_WORDS_OF_PLAN = 10
  COUNT_WORDS_OF_DESCRIPTION = 10
  MINIMUM_LENGTH_OF_NAME = 4

  validates :name, length: { minimum: MINIMUM_LENGTH_OF_NAME }
  validates :plan, count_words: { minimum: COUNT_WORDS_OF_PLAN }
  validates :description, count_words: { minimum: COUNT_WORDS_OF_DESCRIPTION }
end
