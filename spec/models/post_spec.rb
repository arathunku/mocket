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
#

require 'spec_helper'

describe Post do
  before { @post = FactoryGirl.build(:post) }

  subject { @post }

  it { should respond_to(:archived) }
  it { should respond_to(:favorite) }
  it { should respond_to(:search) }

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
  end
end
