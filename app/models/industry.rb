class Industry < ApplicationRecord
  has_many :local_industries, dependent: :destroy
  has_many :sponsor_industries, dependent: :destroy
  has_many :ideas, through: :local_industries
  has_many :users, through: :sponsor_industries

  validates :name, presence: true, uniqueness: true
end
