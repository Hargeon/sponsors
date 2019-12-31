require 'rails_helper'

RSpec.describe LocalIndustry, type: :model do
  describe 'Uniq ids' do
    let(:industry) { Industry.first }
    it 'should be invalid' do
      idea = create(:idea)
      new_industry = idea.local_industries.build(industry_id: industry.id)
      expect(new_industry.valid?).to eq(false)
    end
  end
end
