class Member < ApplicationRecord
  has_many :local_members
  has_many :ideas, through: :local_members

  validates :name, presence: true, uniqueness: true
end