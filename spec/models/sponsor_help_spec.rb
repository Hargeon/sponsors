require 'rails_helper'

RSpec.describe SponsorHelp, type: :model do
  describe 'Uniq ids' do
    let(:require_help) { create(:require_help) }
    let(:user) { create(:user)}

    before do
      user.sponsor_helps.create(require_help_id: require_help.id)
    end

    it 'should add to database' do
      expect(SponsorHelp.count).to eq(1)
    end

    it 'should be invalid' do
      new_help = user.sponsor_helps.build(require_help_id: require_help.id)
      expect(new_help.valid?).to eq(false)
    end
  end
end
