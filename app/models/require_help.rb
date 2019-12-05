class RequireHelp < ApplicationRecord
  has_many :local_require_helps
  has_many :ideas, through: :local_require_helps

  validates :name, presence: true, uniqueness: true
end
