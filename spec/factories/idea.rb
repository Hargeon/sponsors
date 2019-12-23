FactoryBot.define do
  factory :idea do
    name { 'Simple name' }
    description { 'one two three fout five six seven eight nine ten' }
    plan { 'one two three fout five six seven eight nine ten' }
    before :create do |idea|
      idea.industries << create(:industry)
      idea.districts << create(:district)
      idea.local_members << LocalMember.create(amount: 2, member_id: create(:member).id)
      idea.require_helps << create(:require_help)
    end
  end
end
