# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :album do
    artist
    sequence(:title) {|n| "title-#{n*3}" }
    sequence(:mbid) {|n| "#{n*2}-#{n*3}" }
  end
end
