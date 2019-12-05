class District < ApplicationRecord
  has_many :local_districts
  has_many :ideas, through: :local_districts

  validates :name, presence: true, uniqueness: true
end
