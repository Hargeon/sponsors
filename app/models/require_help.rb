class RequireHelp < ApplicationRecord
  has_many :local_require_helps, dependent: :destroy
  has_many :sponsor_helps, dependent: :destroy
  has_many :ideas, through: :local_require_helps
  has_many :users, through: :sponsor_helps

  validates :name, presence: true, uniqueness: true
end
