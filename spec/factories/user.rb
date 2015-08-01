FactoryGirl.define do
  factory :user do
    sequence(:name) { |n| "User #{n}" }
    total_score { (rand*1000).round }
  end
end
