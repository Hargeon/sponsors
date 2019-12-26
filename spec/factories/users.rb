FactoryBot.define do
  factory :user do
    name { 'Some name' }
    email { 'example@gmail.com' }
    password { 'password' }
    age { 22 }
    phone { '+37529123654' }
  end
end
