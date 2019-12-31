require 'rails_helper'

RSpec.describe LocalMember, type: :model do
  describe 'validate' do
    it { should validate_numericality_of(:amount).only_integer }
    it { should validate_numericality_of(:amount).is_greater_than_or_equal_to(0) }
  end

  describe 'Uniq ids' do
    let(:member) { Member.first }
    it 'should be invalid' do
      idea = create(:idea)
      new_member = idea.local_members.build(member_id: member.id)
      expect(new_member.valid?).to eq(false)
    end
  end
end
