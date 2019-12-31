require 'rails_helper'

RSpec.describe SponsorIndustry, type: :model do
  describe 'Uniq ids' do
    let(:industry) { create(:industry) }
    let(:user) { create(:user)}

    before do
      user.sponsor_industries.create(industry_id: industry.id)
    end

    it 'should add to database' do
      expect(SponsorIndustry.count).to eq(1)
    end

    it 'should be invalid' do
      new_industry = user.sponsor_industries.build(industry_id: industry.id)
      expect(new_industry.valid?).to eq(false)
    end
  end
end
