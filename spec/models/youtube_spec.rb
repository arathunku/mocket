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
  end
end
