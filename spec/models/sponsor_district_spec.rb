require 'rails_helper'

RSpec.describe SponsorDistrict, type: :model do
  it { should validate_uniqueness_of(:user_id).scoped_to(:district_id) }
end
