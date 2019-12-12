require 'rails_helper'

RSpec.describe LocalMember, type: :model do
  describe 'validate' do
    it 'amount of member' do
      idea = create(:idea)
      member = create(:member)
      local_member = idea.local_members.new(amount: 20, member_id: member.id)
      expect(local_member.valid?).to eq(true)
    end
  end
end
