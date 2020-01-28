class Idea < ApplicationRecord
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  mapping do
    indexes :name
    indexes :description
    indexes :plan

    indexes :industries, type: :object do
      indexes :name
    end

    indexes :districts, type: :object do
      indexes :name
    end

    indexes :require_helps, type: :object do
      indexes :name
    end

    indexes :members, type: :object do
      indexes :name
    end
  end

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
  ACTIVE_TIME_PERIOD = 30
  ACTIVE_NOTIFICATION_PERIOD = 10

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
  scope :inactive, -> { where(active: false) }
  scope :active_period, (lambda do
    active.where('active_time < ?', ACTIVE_TIME_PERIOD.day.ago)
  end)

  scope :notification_period, (lambda do
    active.where('active_time < ? ', (ACTIVE_TIME_PERIOD - ACTIVE_NOTIFICATION_PERIOD).day.ago,)
  end)

  def update_active_period?
    self.active_time < (ACTIVE_TIME_PERIOD - ACTIVE_NOTIFICATION_PERIOD).day.ago
  end

  def as_indexed_json(options = {})
    self.as_json(
      include: {
        industries: { only: [:name] },
        districts: { only: [:name] },
        require_helps: { only: [:name] },
        members: { only: [:name] }
      }
    )
  end

  def self.search(query)
    __elasticsearch__.search(
      {
        query: {
          bool: {
            must: [
              {
                multi_match: {
                  query: query,
                  fields: [
                    :name, :description, :plan,
                    'industries.name', 'districts.name', 'require_helps.name',
                    'members.name'
                  ]
                }
              },
              {
                match: {
                  active: true
                }
              }
            ]
          }
        },
        sort: [
          { created_at: :desc }
        ]
      }
    )
  end

  private

  def set_active
    self.active = true
  end

  def set_active_time
    self.active_time = Time.zone.now
  end
end
