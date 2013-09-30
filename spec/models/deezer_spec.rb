require 'spec_helper'

describe Deezer do
  before { @deezer = Deezer.new('abcd123') }

  describe "methods" do
    it "#name" do
      expect(@deezer.name).to eq('deezer')
    end

    it "#deezer" do
      expect(@deezer.html).to match(/#{@deezer.id}/)
      expect(@deezer.html).to match(/iframe/)
    end

    describe "#get_id" do
      it "proper json" do
        stub_request(:get, "http://api.deezer.com/search?q=#{URI.escape('coma angela')}&access_token=#{ENV['DEEZER_ACCESS']}").
           with(:headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'User-Agent'=>'Ruby'}).
           to_return(:status => 200, :body => "{\"data\":[{\"id\":\"65017742\"}],\"total\":1}", :headers => {})
        expect(Deezer.get_id('coma angela')).to eq('65017742')
      end

      it "inproper json" do
        stub_request(:get, "http://api.deezer.com/search?q=#{URI.escape('coma angela')}&access_token=#{ENV['DEEZER_ACCESS']}").
           with(:headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'User-Agent'=>'Ruby'}).
           to_return(:status => 200, :body => "'", :headers => {})
        expect(Deezer.get_id('coma angela')).to eq(nil)
      end
    end
  end
end