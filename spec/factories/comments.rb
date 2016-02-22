FactoryGirl.define do
  factory :comment do
    association :user, factory: :user
    association :idea, factory: :idea

    sequence(:body)       { |n| "#{Faker::Lorem.paragraph}-#{n}" }
  end
end
