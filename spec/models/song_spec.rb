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

  context "callbacks " do
  end

  context "methods: " do
    describe "#lastfm_information" do
      before do
        Song.stub(:get_json_from).and_return(search_hash)
      end

      it "should return hash with information" do
        info = Song.lastfm_information("coma - transfuzja")
        expect(info.class).to be(Hash)
      end

      it "should call search" do
        expect(Song).to receive(:create_link).once.with('track.search', {track: 'coma'})
        expect(Song).to receive(:create_link).once.with('track.getInfo', {mbid: search_hash["results"]["trackmatches"]["track"].first["mbid"]})
        info = Song.lastfm_information("coma")
      end

      it "should call get json twice" do
        expect(Song).to receive(:get_json_from).twice
        info = Song.lastfm_information("coma - transfuzja")
      end
    end

    describe "#create_from_lastfm" do
      before(:each) do
        Song.stub(:lastfm_information).and_return(song_lastfm)
        Song.any_instance.stub(:update_youtube).and_return(true)
        Song.any_instance.stub(:update_spotify).and_return(true)
        @artist = FactoryGirl.create(:artist)
        @album = FactoryGirl.create(:album, artist: @artist)
      end

      it "calls for lastfm information" do
        expect(Song).to receive(:lastfm_information) { song_lastfm }
        Song.create_from_lastfm("coma - transfuzja")
      end

      it "calls for fill_up_tags" do
        Artist.should_receive(:find_or_create).and_return(@artist)
        expect(@artist).to receive(:fill_up_tags)
        Song.create_from_lastfm("coma - transfuzja")
      end


      context "song found" do
        before(:each) do
          Artist.stub(:find_or_create).and_return(@artist)
          Album.stub(:find_or_create).and_return(@album)
          Artist.any_instance.stub(:fill_up_tags).and_return(true)
        end

        it "call for artist" do
          expect(Artist).to receive(:find_or_create) { @artist }
          Song.create_from_lastfm("coma - transfuzja")
        end

        it "call for album" do
          expect(Album).to receive(:find_or_create) { @album }
          Song.create_from_lastfm("coma - transfuzja")
        end

        it "calls for update_youtube " do
          Song.any_instance.should_receive(:update_youtube)
          Song.create_from_lastfm("coma - transfuzja")
        end

        it "calls for update_spotify" do
          Song.any_instance.should_receive(:update_spotify)
          Song.create_from_lastfm("coma - transfuzja")
        end

        it "creates song" do
          expect {
            Song.create_from_lastfm("coma - transfuzja")
          }.to change{Song.count}.by(1)
        end
      end
    end

    describe "#tags" do
      before(:each) do
        @song = FactoryGirl.create(:song)
      end

      it "returns array" do
        expect(@song.tags.class).to eq(Array)
      end
    end

    describe "#full_name" do
      it "return information with artist" do
        expect(@song.full_name).to eq("#{@song.artist.name} - #{@song.name}")
      end
      it "if no artist(no song!) return name" do
        @song.artist_id = nil
        expect(@song.full_name).to eq("#{@song.name}")
      end
    end

    it "#youtube" do
      expect(@song.youtube.class).to eq(Youtube)
    end

    it "#spotify" do
      expect(@song.spotify.class).to eq(Spotify)
    end

    describe "#update_youtube" do
      it "calls for youtube information" do
        Youtube.stub(:videos_by)
        YouTubeIt::Response::VideoSearch.stub(:videos).and_return([])
        Youtube.should_receive(:videos_by).and_return(YouTubeIt::Response::VideoSearch)
        @song.update_youtube
      end
    end

    describe "#update_spotify" do
      it "calls for spotify information" do
        Spotify.should_receive(:get_id).and_return('id')
        @song.update_spotify
      end
    end

    describe "#serices" do
      it "empty array if no service" do
        @song.youtube_id = nil
        @song.spotify_id = nil
        expect(@song.services).to eq([])
      end

      it "contain youtube" do
        expect(@song.services).to include(@song.youtube)
      end
    end
  end
end
