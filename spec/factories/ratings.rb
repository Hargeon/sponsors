FactoryBot.define do
  factory :rating do
    attraction { 1.5 }
    strategy { 1.5 }
    competitiveness { 1.5 }
    finance { 1.5 }
    idea_id { 1 }
    user_id { 1 }
  end
end
