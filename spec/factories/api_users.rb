FactoryBot.define do
  factory :api_user do
    email {  Faker::Internet.email }
    password { 'Test1234!!' }
    password_confirmation { 'Test1234!!' }
  end
end
