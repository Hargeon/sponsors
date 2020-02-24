require 'rails_helper'

RSpec.describe Interest, type: :model do
  it { should validate_uniqueness_of(:user_id).scoped_to(:idea_id) }
  it { should validate_length_of(:message).is_at_most(100) }

  describe 'Message validation' do
    let(:idea) { create(:idea) }
    let(:sponsor) { create(:sponsor) }
    let(:message) { 'q w e r t y u i o p l k j a' }

    context 'has more than 10 words' do
      it 'should be valid' do
        interest = sponsor.interests.build(idea_id: idea.id, message: message)
        expect(interest.valid?).to eq(true)
      end
    end

    context 'has less than 10 words' do
      let(:message) { 'r t y u i' }

      it 'should be invalid' do
        interest = sponsor.interests.build(idea_id: idea.id, message: message)
        expect(interest.valid?).to eq(false)
      end
    end
  end
end
