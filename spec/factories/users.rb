FactoryBot.define do
  factory :user do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    username { Faker::Internet.username }
    email {  Faker::Internet.email }
    password { 'Password1!' }
    password_confirmation { 'Password1!' }
    
    trait :customer do
      role { :customer }
    end

    trait :admin do
      role { :admin }
    end

  end

end