require 'spec_helper'

describe Spotify do
  before { @spotify = Spotify.new('abcd123') }

  describe "methods" do
    it "#name" do
      expect(@spotify.name).to eq('spotify')
    end

    it "#spotify" do
      expect(@spotify.html).to match(/#{@spotify.id}/)
      expect(@spotify.html).to match(/iframe/)
    end

    it "#get_information" do
      MetaSpotify::Track.should_receive(:lookup).and_return(nil)
      expect(Spotify.get_information("99wfV4gMLYY")).to eq(nil)
    end
  end
end
