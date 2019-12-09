class Idea < ApplicationRecord
  has_many :local_require_helps, dependent: :destroy
  has_many :local_members, dependent: :destroy
  has_many :local_districts, dependent: :destroy
  has_many :local_industries, dependent: :destroy
  has_many :industries, through: :local_industries
  has_many :districts, through: :local_districts
  has_many :members, through: :local_members
  has_many :require_helps, through: :local_require_helps

  accepts_nested_attributes_for :local_industries
  accepts_nested_attributes_for :local_districts
  accepts_nested_attributes_for :local_members
  accepts_nested_attributes_for :local_require_helps

  COUNT_WORDS_OF_PLAN = 10
  COUNT_WORDS_OF_DESCRIPTION = 10
  MINIMUM_LENGTH_OF_NAME = 4

  validates :name, length: { minimum: MINIMUM_LENGTH_OF_NAME }
  validates :plan, count_words: { minimum: COUNT_WORDS_OF_PLAN }
  validates :description, count_words: { minimum: COUNT_WORDS_OF_DESCRIPTION }
end
