# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :artists_tag, :class => 'ArtistsTags' do
    artist
    tag
  end
end
