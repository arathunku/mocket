# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :song do
    #album_id 1
    artist
    lastfm_link "lastfm link"
    sequence(:mbid) {|n| "#{n*2}-#{n*3}" }
    sequence(:name) {|n| "name of the song" }
    sequence(:youtube_id) {|n| "id_#{n*2}-#{n*3}" }
    sequence(:spotify_id) {|n| "id_#{n*2}-#{n*3}" }
    sequence(:deezer_id) {|n| "id_#{n*2}-#{n*3}" }
  end
end
