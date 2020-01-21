FactoryBot.define do
  factory :dislike do
    association :user, factory: :sponsor
    idea
  end
end
