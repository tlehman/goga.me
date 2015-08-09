FactoryGirl.define do
  factory :match do
    association :black_user, factory: :user
    association :white_user, factory: :user
    active true
  end
end
