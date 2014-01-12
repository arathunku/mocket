class Spotify
  attr_accessor :spotify_id
  attr_accessor :id

  # @@client =

  def initialize(spotify_id=nil)
    @spotify_id = spotify_id
    @id = spotify_id
  end

  def self.get_id(name)
    results = MetaSpotify::Track.search(name)
    if results && results[:tracks] && results[:tracks].length > 0
      results[:tracks].first.uri.split(':').last
    else
      nil
    end
  end

  def self.get_information(id='')
    result = MetaSpotify::Track.lookup("spotify:track:#{id}")
    result ? result.name : nil
  end

  def link
    id ? "spotify:track:#{id}" : nil
  end

  def html
    "<div class=\"spotify\"><iframe src=\"https://embed.spotify.com/?uri=#{link}\" width=\"300\" height=\"380\" frameborder=\"0\" allowtransparency=\"true\"></iframe></div>\n"
  end

  def name
    'spotify'
  end
end
