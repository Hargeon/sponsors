require 'rails_helper'

RSpec.describe Interest, type: :model do
  describe 'Uniq values' do
    let(:idea) { create(:idea) }
    let(:sponsor) { create(:user, user_type: 'sponsor', email: 'sponsor@example.com') }

    before do
      sponsor.interests.create(idea_id: idea.id)
    end

    it 'should add interest' do
      expect(Interest.count).to eq(1)
    end

    it 'should be invalid' do
      interest = sponsor.interests.build(idea_id: idea.id)
      expect(interest.valid?).to eq(false)
    end
  end
end
