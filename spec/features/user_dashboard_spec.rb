require 'spec_helper'
include SongInformation

feature 'Favorites' do
  before do
    Song.stub(:lastfm_information).and_return(song_lastfm)
    @user = FactoryGirl.create(:user)
    page.set_rack_session(:user_id => @user.id)
    @song = FactoryGirl.create(:song, name: "Transfuzja")
    @user.posts.create(search: 'transfuzja')
  end

  scenario 'should see nothing if no songs favorited' do
    visit favorites_path
    expect(page).to_not have_content 'Transfuzja'
  end

  scenario 'clicks favorite, should see favorite song ' do
    visit dashboard_path
    click_link 'Favorite'
    visit favorites_path
    expect(page).to have_content 'Transfuzja'
  end
end

feature 'Archives' do
  before do
    Song.stub(:lastfm_information).and_return(song_lastfm)
    @user = FactoryGirl.create(:user)
    page.set_rack_session(:user_id => @user.id)
    @song = FactoryGirl.create(:song, name: "Transfuzja")
    @user.posts.create(search: 'transfuzja')
  end

  scenario 'should see nothing if no songs archived' do
    visit archives_path
    expect(page).to_not have_content 'Transfuzja'
  end

  scenario 'clicks Archive, should see archived song ' do
    visit dashboard_path
    click_link 'Archive'
    visit archives_path
    expect(page).to have_content 'Transfuzja'
  end
end
