# == Schema Information
#
# Table name: songs
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  artist_id   :integer
#  lastfm_link :string(255)
#  mbid        :string(255)
#  album_id    :integer
#  created_at  :datetime
#  updated_at  :datetime
#

require 'spec_helper'
include SongInformation

describe Song do
  before { @song = FactoryGirl.build(:song) }

  subject { @song }

  it { should respond_to(:name) }
  it { should respond_to(:mbid) }
  it { should respond_to(:lastfm_link) }

  it { should be_valid }

  it { should belong_to(:artist) }

  context "validations: " do
    describe "name presence" do
      before { @song.name = '' }
      it { should_not be_valid }
    end

    describe "mbid presence" do
      before { @song.mbid = '' }
      it { should_not be_valid }
    end

    describe "mbid taken" do
      before do
        arist_same_name = @song.dup
        arist_same_name.name = "different #{@song.name}"
        arist_same_name.save
      end

      it { should_not be_valid }
    end
  end

  context "callbacks: " do
  end

  context "methods: " do
    describe "#lastfm_information" do
      it "should return hash with information" do
        info = Song.lastfm_information("coma - transfuzja")
        expect(info.class).to be(Hash)
      end
    end

    describe "#create_from_lastfm" do
      it "calls for lastfm information" do
        Song.stub(:lastfm_information).and_return(song_lastfm)
        expect(Song).to receive(:lastfm_information) { song_lastfm }
        Song.create_from_lastfm("coma - transfuzja")
      end

      context "song found" do
        before(:each) do
          Song.stub(:lastfm_information).and_return(song_lastfm)
          Artist.stub(:find_or_create).and_return(FactoryGirl.create(:artist))
        end

        it "call for artist" do
          expect(Artist).to receive(:find_or_create) { FactoryGirl.create(:artist) }
          Song.create_from_lastfm("coma - transfuzja")
        end

        it "creates song" do
          expect {
            Song.create_from_lastfm("coma - transfuzja")
          }.to change{Song.count}.by(1)
        end
      end
    end
  end
end
