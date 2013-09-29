require 'spec_helper'
include SongInformation

feature 'Add post' do
  before do
    @user = FactoryGirl.create(:user)
    page.set_rack_session(:user_id => @user.id)
    visit dashboard_path
    MetaSpotify::Track.stub(:search).and_return(nil)
    Song.stub(:lastfm_information).and_return(song_lastfm)
  end
  scenario 'proper search' do
    fill_in "post_search", with: "coma - transfuzja"
    click_button 'Add'
    expect(page).to have_content 'Transfuzja'
  end
end
