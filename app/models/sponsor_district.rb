class SponsorDistrict < ApplicationRecord
  belongs_to :user
  belongs_to :district

  validates_uniqueness_of :user_id, scope: :district_id
end
