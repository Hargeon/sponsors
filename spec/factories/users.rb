FactoryBot.define do
  factory :user do
    name { 'Some name' }
    email { 'example@example.com' }
    password { 'password' }
    password_confirmation { 'password' }
    age { 22 }
    phone { '+375291236542' }
  end
end
