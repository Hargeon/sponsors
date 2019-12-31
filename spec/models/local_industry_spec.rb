require 'rails_helper'

RSpec.describe LocalIndustry, type: :model do
  it { should validate_uniqueness_of(:industry_id).scoped_to(:idea_id) }
end
