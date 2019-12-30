class LocalRequireHelp < ApplicationRecord
  belongs_to :idea
  belongs_to :require_help

  validates_uniqueness_of :require_help_id, scope: :idea_id
end
