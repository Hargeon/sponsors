require 'rails_helper'

RSpec.describe LocalDistrict, type: :model do
  it { should validate_uniqueness_of(:district_id).scoped_to(:idea_id) }
end
