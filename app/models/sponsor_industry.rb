class SponsorIndustry < ApplicationRecord
  belongs_to :user
  belongs_to :industry

  validates_uniqueness_of :user_id, scope: :industry_id
end
