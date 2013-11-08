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

  context "methods" do
    describe "#fillup_song" do
      it "calls for information with search attribute" do
        @song = FactoryGirl.build(:song)
        Song.should_receive(:create_from_lastfm).with(@post.search).and_return(@song)
        @post.save!
      end

      it "after create callback" do
        @post.should_receive(:fillup_song)
        @post.save!
      end

      it "assigns song id to post" do
        @song = FactoryGirl.create(:song)
        Song.stub(:create_from_lastfm).and_return(@song)
        @post.save!
        expect(@post.reload.song_id).to eq(@song.id)
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
  end
end
