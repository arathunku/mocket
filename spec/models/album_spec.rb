# == Schema Information
#
# Table name: albums
#
#  id         :integer          not null, primary key
#  artist_id  :integer
#  title      :string(255)
#  mbid       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

require 'spec_helper'

describe Album do
  before { @album = FactoryGirl.build(:album) }

  subject { @album }

  it { should respond_to(:title) }
  it { should respond_to(:mbid) }
  it { should respond_to(:artist_id) }

  it { should belong_to(:artist) }

  it { should be_valid }

  context "validations: " do
    describe "title not present" do
      before { @album.title = '' }
      it { should_not be_valid }
    end

    describe "mbid not present" do
      before { @album.mbid = '' }
      it { should_not be_valid }
    end

    describe "artist_id not present" do
      before { @album.artist_id = '' }
      it { should_not be_valid }
    end
  end

  context "methods: " do
    describe "#find_or_create" do
      before do
        @artist = FactoryGirl.create(:artist)
        @album = {
          "title"=>"Hiptertrofia",
          "mbid"=>"56a5a8a6-37e8-4079-8b08-5cb1022bdb9b"
        }
      end
      it "find exisitng album" do
        album_created = Album.create(mbid: @album["mbid"], title: @album["title"], artist_id: @artist.id)
        album_found = Album.find_or_create(@album, @artist)
        expect(album_found).to eq(album_created)
      end

      it "create if does not exist" do
        expect {
          Album.find_or_create(@album, @artist)
        }.to change{Album.count}.by(1)
      end
    end
  end
end
