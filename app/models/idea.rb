class Idea < ApplicationRecord
  belongs_to :user

  has_many :local_require_helps, dependent: :destroy
  has_many :local_members, dependent: :destroy
  has_many :local_districts, dependent: :destroy
  has_many :local_industries, dependent: :destroy
  has_many :industries, through: :local_industries
  has_many :districts, through: :local_districts
  has_many :members, through: :local_members
  has_many :require_helps, through: :local_require_helps
  has_many :interests, dependent: :destroy
  has_many :views, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :dislikes, dependent: :destroy
  has_many :ratings, dependent: :destroy

  accepts_nested_attributes_for :local_industries, allow_destroy: true
  accepts_nested_attributes_for :local_members, allow_destroy: true
  accepts_nested_attributes_for :local_districts, allow_destroy: true
  accepts_nested_attributes_for :local_require_helps, allow_destroy: true

  COUNT_WORDS_OF_PLAN = 10
  COUNT_WORDS_OF_DESCRIPTION = 10
  MINIMUM_LENGTH_OF_NAME = 4

  validates :name, length: { minimum: MINIMUM_LENGTH_OF_NAME }
  validates :plan, count_words: { minimum: COUNT_WORDS_OF_PLAN }
  validates :description, count_words: { minimum: COUNT_WORDS_OF_DESCRIPTION }
  validates :local_industries, presence: true
  validates :local_members, presence: true
  validates :local_districts, presence: true
  validates :local_require_helps, presence: true

  before_create :set_active
  before_create :set_active_time

  scope :active, -> { where(active: true) }

  private

  def set_active
    self.active = true
  end

  def set_active_time
    self.active_time = Time.current
  end
end
