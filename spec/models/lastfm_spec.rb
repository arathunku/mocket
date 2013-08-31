require 'spec_helper'
include SongInformation

shared_examples_for LastfmGetter do
  context "class methods" do
    describe "get_json_from" do

      context "proper request" do
        before do
          stub_request(:get, "http://www.example.com/").
            with(:headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'User-Agent'=>'Ruby'}).
            to_return(:status => 200, :body => search_string, :headers => {})
        end

        it "return hash" do
          expect(
            described_class.get_json_from("http://www.example.com").class
          ).to be(Hash)
        end

        it "has a key results" do
          expect(
            described_class.get_json_from("http://www.example.com")["results"].present?
          ).to be(true)
        end
      end

      context "invalid request" do
        before do
          stub_request(:get, "http://www.example.com/").
            with(:headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'User-Agent'=>'Ruby'}).
            to_return(:status => 422, :body => search_string, :headers => {})
        end

        it "return empty hash" do
          expect(
            described_class.get_json_from("http://www.example.com").keys.length
          ).to be(0)
        end
      end

    end

    describe "#create_link" do
      it "sets method properly" do
        expect(described_class.create_link("meta")).to match(/meta/)
      end
      it "sets params properly" do
        expect(described_class.create_link("meta",
          {gra: "endera"})).to match(/gra=endera/)
      end
    end
  end
end

describe Song do
  it_behaves_like LastfmGetter
end