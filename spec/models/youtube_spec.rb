require 'spec_helper'

describe Youtube do
  before { @youtube = Youtube.new('abcd123') }

  describe "methods" do
    it "#name" do
      expect(@youtube.name).to eq('youtube')
    end

    it "#youtube" do
      expect(@youtube.html).to match(/#{@youtube.id}/)
      expect(@youtube.html).to match(/iframe/)
    end

    it "#get_information" do
      youTubeIt = double("YouTubeIt")
      allow(youTubeIt).to receive(:video_by).and_return(nil)
      Youtube.should_receive(:client).and_return(youTubeIt)
      expect(Youtube.get_information("99wfV4gMLYY")).to eq(nil)
    end
  end
end
