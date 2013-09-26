# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :authorization do
    provider "google_oauth2"
    user
    uid "123"
    photo "link_to_photo"
    link "link_to_profile"
  end
end
