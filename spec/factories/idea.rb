FactoryBot.define do
  factory :idea do
    name { 'Simple name' }
    description { 'one two three fout five six seven eight nine ten' }
    plan { 'one two three fout five six seven eight nine ten' }
    active { true }
    active_time { Time.zone.now }

    before :create do |idea|
      idea.industries << create(:industry)
      idea.districts << create(:district)
      idea.local_members << build(:local_member)
      idea.require_helps << create(:require_help)
      idea.user = create(:user)
    end
  end
end
