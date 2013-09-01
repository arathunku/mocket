# Read about factories at https://github.com/thoughtbot/factory_girl
FactoryGirl.define do
  factory :user do
    name "MyString"
    sequence(:email) {|n| "email#{n}@factory.com" }
    invited false
  end
end
