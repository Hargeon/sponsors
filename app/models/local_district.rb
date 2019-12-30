class LocalDistrict < ApplicationRecord
  belongs_to :idea
  belongs_to :district

  validates_uniqueness_of :district_id, scope: :idea_id
end
