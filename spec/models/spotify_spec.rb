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
  end
end
