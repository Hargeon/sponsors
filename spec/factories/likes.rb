FactoryBot.define do
  factory :like do
    association :user, factory: :sponsor
    idea
  end
end
