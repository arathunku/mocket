# == Schema Information
#
# Table name: artists
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  mbid        :string(255)
#  lastfm_link :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#

require 'spec_helper'
include SongInformation

describe Artist do
  before { @artist = FactoryGirl.build(:artist) }

  subject { @artist }

  it { should respond_to(:name) }
  it { should respond_to(:mbid) }
  it { should respond_to(:lastfm_link) }
  it { should be_valid }

  it { should have_many(:songs) }


  context "validations: " do
    describe "name presence" do
      before { @artist.name = '' }
      it { should_not be_valid }
    end

    describe "mbid presence" do
      before { @artist.mbid = '' }
      it { should_not be_valid }
    end

    describe "name taken" do
      before do
        arist_same_name = @artist.dup
        arist_same_name.mbid = "different #{@artist.mbid}"
        arist_same_name.save
      end
      it { should_not be_valid }
    end

    describe "mbid taken" do
      before do
        arist_same_name = @artist.dup
        arist_same_name.name = "different #{@artist.name}"
        arist_same_name.save
      end

      it { should_not be_valid }
    end
  end

  context "methods: " do
    describe "#find_or_create" do
      before do
        @artist = {
          "name"=>"Coma",
          "mbid"=>"19df76fa-76e1-4801-8905-c3a620f96c4d",
          "url"=>"http://www.last.fm/music/Coma"
        }
      end
      it "find exisitng artist" do
        artist_created = Artist.create(mbid: @artist["mbid"], name: @artist["name"])
        artist_found = Artist.find_or_create(@artist)
        expect(artist_found).to eq(artist_created)
      end

      it "create if does not exist" do
        expect {
          Artist.find_or_create(@artist)
        }.to change{Artist.count}.by(1)
      end
    end
  end
end
