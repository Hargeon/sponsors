class User < ApplicationRecord
  has_one_attached :avatar

  has_many :ideas, dependent: :destroy
  has_many :interests, dependent: :destroy
  has_many :sponsor_industries, dependent: :destroy
  has_many :sponsor_districts, dependent: :destroy
  has_many :sponsor_helps, dependent: :destroy
  has_many :industries, through: :sponsor_industries
  has_many :districts, through: :sponsor_districts
  has_many :require_helps, through: :sponsor_helps
  has_many :views, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :dislikes, dependent: :destroy
  has_many :ratings, dependent: :destroy

  accepts_nested_attributes_for :sponsor_districts, allow_destroy: true
  accepts_nested_attributes_for :sponsor_industries, allow_destroy: true
  accepts_nested_attributes_for :sponsor_helps, allow_destroy: true

  MINIMUM_NAME_LENGTH = 4
  MAXIMUN_LENGTH_OF_NAME = 15
  MINIMUM_AGE = 12
  MAXIMUM_AGE = 150

  enum user_type: [:businessman, :sponsor]

  # Include default devise modules. Others available are:
  #:lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :async,
         :recoverable, :rememberable, :validatable, :confirmable,
         :omniauthable, omniauth_providers: [:facebook]

  validates :name, :age, :phone, presence: true
  validates :name, length: { minimum: MINIMUM_NAME_LENGTH, maximum: MAXIMUN_LENGTH_OF_NAME }
  validates :age, numericality: { greater_than_or_equal_to: MINIMUM_AGE, less_than: MAXIMUM_AGE }
  validates :age, numericality: { only_integer: true }
  validates :phone, phone: true
  validates :user_type, presence: true

  scope :sponsors, -> { where(user_type: :sponsor) }
  scope :businessmen, -> { where(user_type: :businessman) }
end
