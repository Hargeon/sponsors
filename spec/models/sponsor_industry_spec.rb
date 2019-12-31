require 'rails_helper'

RSpec.describe SponsorIndustry, type: :model do
  it { should validate_uniqueness_of(:user_id).scoped_to(:industry_id) }
end
