FactoryBot.define do
  factory :user do
    name { 'Some name' }
    email { 'example@gmail.com' }
    password { 'password' }
  end
end
