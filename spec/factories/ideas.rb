FactoryGirl.define do
  factory :idea do
    association :user, factory: :user

    sequence(:title)        { |n| "#{Faker::Company.bs}-#{n}" }
    sequence(:description)  { |n| "#{Faker::Lorem.paragraph}-#{n}" }
  end
end
