require 'rails_helper'

RSpec.describe LocalMember, type: :model do
  describe 'validate' do
    it 'has amount' do
      idea = create(:idea)
      expect(idea.local_members.first.valid?).to eq(true)
    end

    it 'has not amount' do
      idea = create(:idea)
      member = create(:member, name: "Other name")
      local_member = idea.local_members.new(member_id: member.id)
      expect(local_member.valid?).to eq(false)
    end

    it 'has a negative amount' do
      idea = create(:idea)
      member = create(:member, name: "Other name")
      local_member = idea.local_members.new(amount: -1, member_id: member.id)
      expect(local_member.valid?).to eq(false)
    end
  end
end
