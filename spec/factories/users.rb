FactoryBot.define do
  factory :user do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    username { Faker::Internet.username(specifier: 2, separators: %w()) } #minimum 2 letters and only letters
    email {  Faker::Internet.email }
    password { 'Test1234!!' }
    password_confirmation { 'Test1234!!' }
    
    trait :customer do
      role { :customer }
    end

    trait :admin do
      role { :admin }
    end

  end

end