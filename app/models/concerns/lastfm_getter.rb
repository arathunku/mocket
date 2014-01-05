module LastfmGetter
  extend ActiveSupport::Concern
  require "json"
  require "net/http"
  require "uri"

  module ClassMethods
    def create_link(method, additional_params={})
      api_key = ENV["LASTFM_API_KEY"]
      link = "http://ws.audioscrobbler.com/2.0/?method="
      link += method
      link += "&api_key=#{api_key}"
      link += "&format=json"
      additional_params.each_pair do |key, value|
        link += "&#{key}=#{URI.escape(value)}"
      end
      link
    end

    def get_json_from(link)
      uri = URI.parse(link)
      http = Net::HTTP.new(uri.host, uri.port)
      request = Net::HTTP::Get.new(uri.request_uri)
      response = http.request(request)
      if response.code == "200"
        result = JSON.parse(response.body)
        result
      else
        {}
      end
    end
  end
end
