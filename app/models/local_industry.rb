class LocalIndustry < ApplicationRecord
  belongs_to :idea
  belongs_to :industry

  validates_uniqueness_of :industry_id, scope: :idea_id
end
