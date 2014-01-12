# Read about factories at https://github.com/thoughtbot/factory_girl
FactoryGirl.define do
  factory :user do
    name "MyString"
    sequence(:email) {|n| "email#{n}@factory.com" }
    invited true
    after(:create) do |user|
      user.authorizations = [create(:authorization, user_id: user.id)]
    end
    after(:build) do |user|
      user.authorizations = [build(:authorization, user_id: user.id)]
    end
  end
end
