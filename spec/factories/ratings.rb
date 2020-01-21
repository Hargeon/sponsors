FactoryBot.define do
  factory :rating do
    attraction { 5 }
    strategy { 3 }
    competitiveness { 4 }
    finance { 2 }
    idea
    association :user, factory: :sponsor
  end
end
