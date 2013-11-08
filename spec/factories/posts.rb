# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :post do
    user
    archived false
    favorite false
    song_url 'http://www.youtube.com/?v=ij12i3jisaii'
    source_url 'http://www.facebook.com/posts/123213213213'
    search 'n'
  end
end
