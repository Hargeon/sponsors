class User < ApplicationRecord
  has_many :ideas, dependent: :destroy

  MINIMUM_NAME_LENGTH = 4
  MINIMUM_AGE = 12

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, :age, :phone, presence: true
  validates :name, length: { minimum: MINIMUM_NAME_LENGTH }
  validates :age, numericality: { greater_than_or_equal_to: MINIMUM_AGE }
  validates :age, numericality: { only_integer: true }
  validates :phone, phone: true
end
