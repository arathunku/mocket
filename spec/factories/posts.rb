# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :post do
    user
    archived false
    favorite false
    search 'n'
  end
end
