class User < ApplicationRecord
  has_many :ideas, dependent: :destroy

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, :age, :phone, presence: true
  validates :name, length: { minimum: 4 }
  validates :age, numericality: { greater_than_or_equal_to: 12 }
  validates :age, numericality: { only_integer: true }
  validates :phone, phone: true
end
