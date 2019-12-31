require 'rails_helper'

RSpec.describe SponsorDistrict, type: :model do
  describe 'Uniq ids' do
    let(:district) { create(:district) }
    let(:user) { create(:user)}

    before do
      user.sponsor_districts.create(district_id: district.id)
    end

    it 'should add to database' do
      expect(SponsorDistrict.count).to eq(1)
    end

    it 'should be invalid' do
      new_district = user.sponsor_districts.build(district_id: district.id)
      expect(new_district.valid?).to eq(false)
    end
  end
end
