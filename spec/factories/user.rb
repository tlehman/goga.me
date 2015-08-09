FactoryGirl.define do
  factory :user do
    sequence(:name) { |n| "User #{n}" }
    sequence(:email) { |n| "user#{n}@example.com" }
    sequence(:password) { |n| "password#{n}@example.com" }

    total_score { (rand*1000).round }
  end
end
