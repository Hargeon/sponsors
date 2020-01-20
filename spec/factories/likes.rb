FactoryBot.define do
  factory :like do
    user_id { create(:sponsor).id }
    idea_id { create(:idea).id }
  end
end
