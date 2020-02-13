FactoryBot.define do
  factory :user do
    name { 'Some name' }
    sequence(:email) { |n| "example#{n}@example.com" }
    password { 'password' }
    password_confirmation { 'password' }
    age { 22 }
    phone { '+375291236542' }
    user_type { 'businessman' }

    before :create do |user|
      user.skip_confirmation!
    end

    factory :sponsor do
      user_type { 'sponsor' }
    end
  end
end
