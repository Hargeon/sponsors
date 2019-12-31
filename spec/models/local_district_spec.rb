require 'rails_helper'

RSpec.describe LocalDistrict, type: :model do
  describe 'Uniq ids' do
    let(:district) { District.first }
    it 'should be invalid' do
      idea = create(:idea)
      new_district = idea.local_districts.build(district_id: district.id)
      expect(new_district.valid?).to eq(false)
    end
  end
end
