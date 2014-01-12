# == Schema Information
#
# Table name: posts
#
#  id         :integer          not null, primary key
#  song_id    :integer
#  user_id    :integer
#  archived   :boolean
#  favorite   :boolean
#  search     :string(255)
#  created_at :datetime
#  updated_at :datetime
#  source_url :string(255)
#  song_url   :string(255)
#

require 'spec_helper'

describe Post do
  before { @post = FactoryGirl.build(:post) }

  subject { @post }

  it { should respond_to(:archived) }
  it { should respond_to(:favorite) }
  it { should respond_to(:search) }
  it { should respond_to(:source_url) }
  it { should respond_to(:song_url) }

  it { should be_valid }

  it { should belong_to(:song) }
  it { should belong_to(:user) }

  context "validations" do
    describe "search presence" do
      before { @post.search = '' }
      it { should_not be_valid }
    end
  end

  it "after create callbacks" do
    @post.should_receive(:detect_uri)
    @post.should_receive(:fillup_song)
    @post.save!
  end

  context "methods" do
    describe "#detect_uri" do
      it "detects URI from search and moves it to song_url" do
        uri = "https://www.youtube.com/watch?v=xxxxxxx"
        Song.stub(:create_from_lastfm)
        post = FactoryGirl.build(:post,
          search: uri,
          song_url: ''
        )
        post.detect_uri
        expect(post.song_url).to eq(uri)
      end
    end

    describe "#fillup_song" do
      it "get ID from song_url if present" do
        @post.song_url = "https://www.youtube.com/watch?v=abcd"
        @song = FactoryGirl.build(:song)
        @post.should_receive(:get_service_id_from_uri)
        Song.stub(:create_from_lastfm).and_return(nil)
        @post.fillup_song
      end

      it "calls for information with search attribute" do
        @song = FactoryGirl.build(:song)
        Song.should_receive(:create_from_lastfm)
          .with(@post.search, {}).and_return(nil)
        @post.fillup_song
      end

      it "assigns song id to post" do
        @song = FactoryGirl.create(:song)
        Song.stub(:create_from_lastfm).and_return(@song)
        @post.save!
        expect(@post.reload.song_id).to eq(@song.id)
      end
    end

    describe "#get_links" do
      it "result array" do
        expect(Post.get_links([], 'spotify')).to eq([])
      end

      it "call to get link on passed post" do
        post = double("post")
        expect(post).to receive(:get_link).and_return('link')
        Post.get_links([post], 'spotify')
      end

      it "empty array if no link" do
        post = double("post", get_link: nil)
        expect(Post.get_links([post], 'spotify')).to eq([])
      end
    end

    describe "#get_link" do
      it "calls for link" do
        expect_any_instance_of(Spotify).to receive(:link)
        @post.get_link('spotify')
      end
    end

    describe "#song" do
      it "if post does not have song, return new instance of song with search query as name" do
        @post.song_id = nil
        @post.search = "abcd"
        expect(@post.song.id).to eq(nil)
        expect(@post.song.name).to eq(@post.search)
      end

      it "return song object" do
        @song = FactoryGirl.build(:song)
        @post.song_id = @song
        expect(@post.song.id).to eq(@song.id)
      end
    end

    describe "#get_service_id_from_uri" do
      let(:id) { "xasa2321321" }

      it "youtube" do
        @post.song_url = "https://www.youtube.com/watch?v=#{id}"
        expect(@post.get_service_id_from_uri[:youtube]).to eq(id)
      end

      it "spotify" do
        @post.song_url = "spotify:track:#{id}"
        expect(@post.get_service_id_from_uri[:spotify]).to eq(id)
      end

      it "deezer" do
        @post.song_url = "http://www.deezer.com/track/#{id}"
        expect(@post.get_service_id_from_uri[:deezer]).to eq(id)
      end

    end
  end
end
