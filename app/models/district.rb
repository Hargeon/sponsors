class District < ApplicationRecord
  has_many :local_districts, dependent: :destroy
  has_many :sponsor_districts, dependent: :destroy
  has_many :ideas, through: :local_districts
  has_many :users, through: :sponsor_districts

  validates :name, presence: true, uniqueness: true
end
