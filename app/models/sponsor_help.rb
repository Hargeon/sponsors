class SponsorHelp < ApplicationRecord
  belongs_to :user
  belongs_to :require_help

  validates_uniqueness_of :user_id, scope: :require_help_id
end
