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
#  youtube_id  :string(255)
#  spotify_id  :string(255)
#  deezer_id   :string(255)
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
        Song.any_instance.stub(:get_youtube).and_return(true)
        Song.any_instance.stub(:get_spotify).and_return(true)
        Song.any_instance.stub(:get_deezer).and_return(true)
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
          Youtube.stub(:get_youtube_information)
          Spotify.stub(:get_spotify_information)
          Deezer.stub(:get_deezer_information)
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

        it "calls for get_youtube " do
          Song.any_instance.should_receive(:get_youtube)
          Song.create_from_lastfm("coma - transfuzja")
        end

        it "calls for get_spotify" do
          Song.any_instance.should_receive(:get_spotify)
          Song.create_from_lastfm("coma - transfuzja")
        end

        it "calls for get_deezer" do
          Song.any_instance.should_receive(:get_deezer)
          Song.create_from_lastfm("coma - transfuzja")
        end

        it "ommit call for get_youtube if id passed" do
          Song.any_instance.should_not_receive(:get_youtube)
          Song.any_instance.should_receive(:update_attributes)
          Song.any_instance.stub(:get_youtube_information)
            .and_return("coma - transfuzja")
          Song.create_from_lastfm("coma - transfuzja", {youtube: "1"})
        end

        it "get youtube information if youtube_id passed" do
          Song.any_instance.should_not_receive(:get_youtube)
          Song.any_instance.should_receive(:get_youtube_information)
            .and_return()
          Song.create_from_lastfm("1", {youtube: "1"})
        end

        it "set information variable to new name" do
          Song.any_instance.stub(:get_youtube_information)
            .and_return("coma - transfuzja")
          expect(Song).to receive(:lastfm_information)
            .with("coma - transfuzja") { song_lastfm }
          Song.create_from_lastfm("1", {youtube: "1"})
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

    describe "#youtube" do
      it "id is nil" do
        @song.youtube_id = nil
        expect(@song.youtube.id).to eq(nil)
      end

      it "valid id" do
        expect(@song.youtube.id).to eq(@song.youtube_id)
      end
    end

    describe "#spotify" do
      it "id is nil" do
        @song.spotify_id = nil
        expect(@song.spotify.id).to eq(nil)
      end

      it "valid id" do
        expect(@song.spotify.id).to eq(@song.spotify_id)
      end
    end

    describe "#deezer" do
      it "id is nil" do
        @song.deezer_id = nil
        expect(@song.deezer.id).to eq(nil)
      end

      it "valid id" do
        expect(@song.deezer.id).to eq(@song.deezer_id)
      end
    end

    describe "#get_youtube" do
      it "calls for youtube information" do
        Youtube.stub(:videos_by)
        YouTubeIt::Response::VideoSearch.stub(:videos).and_return([])
        Youtube.should_receive(:videos_by).and_return(YouTubeIt::Response::VideoSearch)
        @song.get_youtube
      end
    end

    describe "#get_spotify" do
      it "calls for spotify information" do
        Spotify.should_receive(:get_id).and_return('id')
        @song.get_spotify
      end
    end

    describe "#update_deezer" do
      it "calls for deezer information" do
        Spotify.should_receive(:get_id).and_return('id')
        @song.get_spotify
      end
    end

    describe "#serices" do
      it "empty array if no service" do
        @song.youtube_id = nil
        @song.spotify_id = nil
        @song.deezer_id = nil
        expect(@song.services).to eq([])
      end

      it "contain given service" do
        expect(@song.services).to include(@song.youtube)
        expect(@song.services).to include(@song.spotify)
        expect(@song.services).to include(@song.deezer)
      end
    end

    describe "#services_names" do
      it "call name on service" do
        expect_any_instance_of(Youtube).to receive(:name)
        @song.services_names
      end
    end
  end
end
