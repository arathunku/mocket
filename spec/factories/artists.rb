# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :artist do
    sequence(:name) {|n| "name artist #{n}" }
    sequence(:mbid) {|n| "#{n*2}-#{n*3}" }
    lastfm_link "link"
  end
end
